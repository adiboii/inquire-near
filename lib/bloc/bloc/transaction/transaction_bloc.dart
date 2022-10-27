// Package imports:
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:inquire_near/enums/paypal_status.dart';
import 'package:meta/meta.dart';

// Project imports:
import 'package:inquire_near/data/models/hiring_request.dart';
import 'package:inquire_near/data/models/inquiry_list.dart';
import 'package:inquire_near/data/models/transaction.dart';
import 'package:inquire_near/data/repositories/transaction_repository.dart';
import 'package:inquire_near/data/repositories/user_repository.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  //TODO: get hiringRequest data from previous screen
  HiringRequest? hiringRequest;
  final TransactionRepository transactionRepository;
  final UserRepository userRepository;
  late INTransaction transaction;

  String? store;
  TransactionBloc(
      {required this.transactionRepository, required this.userRepository})
      : super(TransactionInitial()) {
    on<GetHiringRequestDetails>(_onGetHiringDetails);
    on<GetTransactionDetails>(_onGetTransactionDetails);
    on<GetTransactionStatus>(_onGetTransactionStatus);
    on<EmitSuccessfulTransactionStatus>(_onEmitSuccessfulTransactionStatus);
    on<EmitFailedTransactionStatus>(_onEmitFailedTransactionStatus);
    on<ClickStore>(_onClickStore);
  }

  void _onGetHiringDetails(GetHiringRequestDetails event, emit) async {
    emit(Retrieving());
    hiringRequest = event.hiringRequest;
    emit(RetreievedHiringRequestDetails());
  }

  void _onClickStore(ClickStore event, emit) async {
    store = event.store;
  }

  void _onGetTransactionDetails(GetTransactionDetails event, emit) async {
    emit(Retrieving());

    INTransaction transaction = await transactionRepository
        .getTransactionDetails(hiringRequest!.transactionId);

    transaction.uid = hiringRequest!.transactionId;

    this.transaction = transaction;

    Map<String, dynamic> userData =
        await userRepository.getUserData(hiringRequest!.clientId);

    InquiryList inquiryList =
        await transactionRepository.getInquiryList(transaction.inquiryListID);

    inquiryList.uid = transaction.inquiryListID;

    emit(RetrievedTransactionDetails(
      transaction: transaction,
      userData: userData,
      inquiryList: inquiryList,
    ));
  }

  late StreamSubscription transactionStatusListener;
  void _onGetTransactionStatus(event, emit) {
    transactionStatusListener = FirebaseFirestore.instance
        .collection('transaction')
        .doc(transaction.id)
        .snapshots()
        .listen((ev) async {
      INTransaction t = INTransaction.fromJson(ev.data()!);

      if (t.payPalStatus == PayPalStatus.success) {
        add(EmitSuccessfulTransactionStatus(t.payPalID.toString()));
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
}
