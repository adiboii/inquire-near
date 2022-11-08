part of 'inquirer_bloc.dart';

abstract class InquirerEvent extends Equatable {
  const InquirerEvent();

  @override
  List<Object> get props => [];
}

class Initial extends InquirerEvent {}

class ToggleIsOnline extends InquirerEvent {
  final bool isOnline;

  const ToggleIsOnline(this.isOnline);
}

class NewHiringRequestFound extends InquirerEvent {
  final HiringRequest hiringRequest;

  const NewHiringRequestFound(this.hiringRequest);
}

class AcceptRequest extends InquirerEvent {
  final String transactionId;

  const AcceptRequest(this.transactionId);
}

class RejectRequest extends InquirerEvent {}
