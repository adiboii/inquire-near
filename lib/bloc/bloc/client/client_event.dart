part of 'client_bloc.dart';

abstract class ClientEvent extends Equatable {
  const ClientEvent();

  @override
  List<Object> get props => [];
}

class FindAvailableInquirers extends ClientEvent {}

class GetAvailableInquirers extends ClientEvent {
  final List<INUser> inquirers;

  const GetAvailableInquirers(this.inquirers);
}

class StopFindAvailableInquirer extends ClientEvent {}

// These are events used inside the bloc to
// prevent Stream errors.
class EmitFindNewAvailableInquirers extends ClientEvent {}

class EmitNoAvailableInquirers extends ClientEvent {}