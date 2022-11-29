// Dart imports:
import 'dart:async';
import 'dart:developer';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:inquire_near/collections.dart';
import 'package:inquire_near/data/models/hiring_request.dart';
import 'package:inquire_near/data/models/in_user.dart';
import 'package:inquire_near/data/models/inquiry_list.dart';
import 'package:inquire_near/data/models/transaction.dart';
import 'package:inquire_near/data/repositories/transaction_repository.dart';
import 'package:inquire_near/data/repositories/user_repository.dart';
import 'package:inquire_near/enums/paypal_status.dart';
import 'package:inquire_near/enums/role.dart';

// import 'package:meta/meta.dart'; // TODO: Check if commenting this still works (CYMMER)

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  //TODO: get hiringRequest data from previous screen (ADI)
  HiringRequest? hiringRequest;
  final TransactionRepository transactionRepository;
  final UserRepository userRepository;
  INTransaction? transaction;
  String? store;
  INUser? client;

  TransactionBloc(
      {required this.transactionRepository, required this.userRepository})
      : super(TransactionInitial()) {
    on<CreateTransaction>(_onCreateTransaction);
    on<GetHiringRequestDetails>(_onGetHiringDetails);
    on<GetTransactionDetails>(_onGetTransactionDetails);
    on<GetTransactionStatus>(_onGetTransactionStatus);
    on<EmitSuccessfulTransactionStatus>(_onEmitSuccessfulTransactionStatus);
    on<EmitFailedTransactionStatus>(_onEmitFailedTransactionStatus);
    on<ClickStore>(_onClickStore);
    on<GetRecentTransaction>(_getRecentTransactions);
    on<ViewRecentTransaction>(_onViewRecentTransaction);
    on<FinishTransaction>(_onFinishTransaction);
  }

  void _onCreateTransaction(CreateTransaction event, emit) async {
    try {
      transaction = INTransaction(
          clientId: event.clientID,
          inquiryListId: event.inquiryListID,
          store: store!,
          isCompleted: false);

      transaction!.setAmount(event.noOfInquiries, event.noOfRequireProof);

      String? id = await transactionRepository.createTransactionAndGetId(
          transaction: transaction!);

      transaction?.id = id;
    } catch (e) {
      log(e.toString());
    }
  }

  void _onGetHiringDetails(GetHiringRequestDetails event, emit) async {
    emit(TransactionLoading());
    hiringRequest = event.hiringRequest;
    emit(RetreievedHiringRequestDetails());
  }

  void _onClickStore(ClickStore event, emit) async {
    store = event.store;
  }

  void _onGetTransactionDetails(GetTransactionDetails event, emit) async {
    emit(TransactionLoading());

    INTransaction transaction = await transactionRepository
        .getTransactionDetails(hiringRequest!.transactionId);
    // Retrieve Client's Data
    client = await transactionRepository.getUserData(transaction.clientId);

    transaction.uid = hiringRequest!.transactionId;

    this.transaction = transaction;

    Map<String, dynamic> userData =
        await userRepository.getUserData(hiringRequest!.clientId);

    InquiryList inquiryList =
        await transactionRepository.getInquiryList(transaction.inquiryListId);

    inquiryList.uid = transaction.inquiryListId;

    emit(RetrievedTransactionDetails(
      transaction: transaction,
      userData: userData,
      inquiryList: inquiryList,
    ));
  }

  late StreamSubscription transactionStatusListener;
  void _onGetTransactionStatus(event, emit) {
    transactionStatusListener = FirebaseFirestore.instance
        .collection(transactionCollection)
        .doc(transaction!.id)
        .snapshots()
        .listen((ev) async {
      INTransaction t = INTransaction.fromJson(ev.data()!);

      if (t.payPalStatus == PayPalStatus.completed) {
        if (t.payPalId.toString() != "" || t.payPalId != null) {
          add(EmitSuccessfulTransactionStatus(t.payPalId.toString()));
        }
      } else if (t.payPalStatus == PayPalStatus.failed) {
        add(EmitFailedTransactionStatus());
      }
    });
  }

  void _onEmitSuccessfulTransactionStatus(event, emit) {
    transactionStatusListener.cancel();
    emit(RetrievedTransactionStatus(event.payPalID));
  }

  void _onEmitFailedTransactionStatus(event, emit) {
    emit(FailedTransactionStatus());
  }

  static Future<bool> hasOngoingTransaction(String userId) async {
    try {
      TransactionRepository tr = TransactionRepository();
      final transactions = await tr.getTransactionsFromUser(userId, false);
      return transactions.docs.isNotEmpty;
    } catch (_) {}

    return false;
  }

  void _getRecentTransactions(GetRecentTransaction event, emit) async {
    emit(TransactionLoading());
    TransactionRepository tr = TransactionRepository();
    List<INTransaction> transactions =
        await tr.getRecentTransactions(event.userId, event.role);

    emit(RetrievedRecentTransactions(recentTransactions: transactions));
  }

  void _onViewRecentTransaction(ViewRecentTransaction event, emit) async {
    emit(TransactionLoading());

    INTransaction recentTransaction = event.transaction;

    Map<String, dynamic> userData =
        await userRepository.getUserData(recentTransaction.clientId);

    InquiryList inquiryList = await transactionRepository
        .getInquiryList(recentTransaction.inquiryListId);

    inquiryList.uid = recentTransaction.inquiryListId;

    emit(RetrievedTransactionDetails(
      transaction: recentTransaction,
      userData: userData,
      inquiryList: inquiryList,
    ));
  }

  void _onFinishTransaction(event, emit) async {
    await transactionRepository.completeTransaction(transaction!.id!);
  }
}
