part of 'client_bloc.dart';

abstract class ClientState extends Equatable {
  const ClientState();
  
  @override
  List<Object> get props => [];
}

class ClientInitial extends ClientState {}

class Empty extends ClientState{}

class NewAvailableInquirersFound extends ClientState {
  final List<INUser> inquirers;

 const  NewAvailableInquirersFound(this.inquirers); 
}

class NoAvailableInquirersFound extends ClientState {}
