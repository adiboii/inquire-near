part of 'inquirer_bloc.dart';

abstract class InquirerEvent extends Equatable {
  const InquirerEvent();

  @override
  List<Object> get props => [];
}

class Initial extends InquirerEvent {}

class ToggleIsOnline extends InquirerEvent {}

class NewHiringRequestFound extends InquirerEvent {
  final HiringRequest hiringRequest;

  const NewHiringRequestFound(this.hiringRequest);
}

class AcceptRequest extends InquirerEvent {}
