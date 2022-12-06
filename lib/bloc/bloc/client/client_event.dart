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

class HireInquirer extends ClientEvent {
  final HiringRequest hiringRequest;

  const HireInquirer(this.hiringRequest);
}

class GetInquirerDetails extends ClientEvent {
  final String inquirerId;

  const GetInquirerDetails(this.inquirerId);
}

class ListenHiringRequest extends ClientEvent {}

class UpdateHiringRequest extends ClientEvent {
  final HiringRequestStatus hiringRequestStatus;

  const UpdateHiringRequest(this.hiringRequestStatus);
}

class CancelHiringRequest extends ClientEvent {}
