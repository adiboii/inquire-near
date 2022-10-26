part of 'transaction_bloc.dart';

abstract class TransactionState extends Equatable {
  @override
  List<Object> get props => [];
}

class TransactionInitial extends TransactionState {}

class Retrieving extends TransactionState {}

class RetreievedHiringRequestDetails extends TransactionState {}

class StoreClicked extends TransactionState {}

class RetrievedTransactionDetails extends TransactionState {
  // This data is composed of transaction details as well as the `user`
  final INTransaction transaction;
  final Map<String, dynamic> userData;
  final InquiryList inquiryList;
  RetrievedTransactionDetails(
      {required this.transaction,
      required this.userData,
      required this.inquiryList});
}
