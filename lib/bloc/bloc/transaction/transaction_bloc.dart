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
  HiringRequest? hiringRequest;
  final TransactionRepository transactionRepository;
  final UserRepository userRepository;
  INTransaction? transaction;
  String? store;
  INUser? client;
  INUser? inquirer;
  StreamSubscription? transactionStatusSubscription;

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
    on<ListenForTransactionStatus>(_onListenForTransactionStatus);
    on<CompleteTransaction>(_onTransactionCompleted);
    on<ClearTransaction>(_onClearTransaction);
    on<DeleteTransaction>(_onDeleteTransaction);
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
    // Retrieve User Data
    transaction.uid = hiringRequest!.transactionId;

    this.transaction = transaction;

    Map<String, dynamic> userData =
        await userRepository.getUserData(hiringRequest!.clientId);

    InquiryList inquiryList =
        await transactionRepository.getInquiryList(transaction.inquiryListId);

    client = await userRepository.getUser(transaction.clientId);

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
      try {
        INTransaction t = INTransaction.fromJson(ev.data()!);

        if (t.payPalStatus == PayPalStatus.completed) {
          if (t.payPalId.toString() != "" || t.payPalId != null) {
            add(EmitSuccessfulTransactionStatus(t.payPalId.toString()));
          }
        } else if (t.payPalStatus == PayPalStatus.failed) {
          add(EmitFailedTransactionStatus());
        }
      } catch (e) {
        log("_onGetTransactionStatus Subscription error > $e");
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

    transaction = event.transaction;
    Map<String, dynamic> userData =
        await userRepository.getUserData(transaction!.clientId);

    client = await userRepository.getUser(transaction!.clientId);
    inquirer = await userRepository.getUser(transaction!.inquirerId!);

    InquiryList inquiryList =
        await transactionRepository.getInquiryList(transaction!.inquiryListId);

    inquiryList.uid = transaction!.inquiryListId;

    emit(RetrievedTransactionDetails(
      transaction: transaction!,
      userData: userData,
      inquiryList: inquiryList,
    ));
  }

  void _onFinishTransaction(event, emit) async {
    await transactionRepository.completeTransaction(transaction!.id!);
  }

  void _onListenForTransactionStatus(event, emit) {
    transactionStatusSubscription = FirebaseFirestore.instance
        .collection(transactionCollection)
        .doc(transaction!.id)
        .snapshots()
        .listen((DocumentSnapshot ev) async {
      if (ev.exists) {
        INTransaction t =
            INTransaction.fromJson(ev.data() as Map<String, dynamic>);
        if (t.isCompleted) {
          add(CompleteTransaction());
        }
      }
    });
  }

  void _onTransactionCompleted(event, emit) async {
    try {
      transactionStatusSubscription?.cancel();
    } catch (_) {}
    transaction =
        await transactionRepository.getTransactionDetails(transaction!.id!);
    emit(TransactionCompleted());
  }

  void _onClearTransaction(event, emit) async {
    transaction = null;
  }

  void _onDeleteTransaction(event, emit) async {
    bool deleteStatus =
        await transactionRepository.deleteTransaction(transaction!.id!);
    try {
      transaction = null;
      transactionStatusSubscription!.cancel();
    } catch (_) {}
    if (deleteStatus) {
      emit(TransactionDeleted());
    } else {
      log("Something went wrong in _onDeleteTransaction.");
    }
  }
}
