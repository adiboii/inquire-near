part of 'transaction_bloc.dart';

abstract class TransactionEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CreateTransaction extends TransactionEvent {
  final String clientID;
  final String inquiryListID;

  final int noOfInquiries;
  final int noOfRequireProof;
  CreateTransaction(
      {required this.clientID,
      required this.inquiryListID,
      required this.noOfInquiries,
      required this.noOfRequireProof});
}

class GetTransactionDetails extends TransactionEvent {
  GetTransactionDetails();
}

class GetHiringRequestDetails extends TransactionEvent {
  final HiringRequest hiringRequest;
  GetHiringRequestDetails({required this.hiringRequest});
}

class GetTransactionStatus extends TransactionEvent {}

class EmitSuccessfulTransactionStatus extends TransactionEvent {
  final String payPalID;

  EmitSuccessfulTransactionStatus(this.payPalID);
}

class EmitFailedTransactionStatus extends TransactionEvent {}

class ClickStore extends TransactionEvent {
  final String store;
  ClickStore({required this.store});
}

class GetRecentTransaction extends TransactionEvent {
  final Role role;
  final String userId;
  GetRecentTransaction({required this.role, required this.userId});
}

class ViewRecentTransaction extends TransactionEvent {
  final INTransaction transaction;
  ViewRecentTransaction({required this.transaction});
}

class FinishTransaction extends TransactionEvent {}

class ListenForTransactionStatus extends TransactionEvent {}

// This event is for the StreamSubscription `transactionStatusSubscription`
class CompleteTransaction extends TransactionEvent {}

class ClearTransaction extends TransactionEvent {}

class DeleteTransaction extends TransactionEvent {}
