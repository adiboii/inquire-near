part of 'transaction_bloc.dart';

abstract class TransactionEvent extends Equatable {
  @override
  List<Object> get props => [];
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
