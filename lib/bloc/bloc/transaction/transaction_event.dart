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
