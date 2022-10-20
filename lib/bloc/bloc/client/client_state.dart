part of 'client_bloc.dart';

abstract class ClientState extends Equatable {
  const ClientState();

  @override
  List<Object> get props => [];
}

class ClientInitial extends ClientState {}

class Empty extends ClientState {}

class NewAvailableInquirersFound extends ClientState {
  final List<INUser> inquirers;

  const NewAvailableInquirersFound(this.inquirers);
}

class NoAvailableInquirersFound extends ClientState {}

class CreateHiringRequestStatus extends ClientState {
  final bool status;

  const CreateHiringRequestStatus(this.status);
}

// Inquirer Profile Details Related States
class Loading extends ClientState {}

class RetrievedInquirerDetails extends ClientState {
  // This data is composed of different statistics, not only `user`
  final Map<String, dynamic> data;

  const RetrievedInquirerDetails(this.data);
}
