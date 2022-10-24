part of 'inquirer_bloc.dart';

abstract class InquirerState extends Equatable {
  final bool isOnline;
  const InquirerState(this.isOnline);

  @override
  List<Object> get props => [];
}

class InquirerInitial extends InquirerState {
  const InquirerInitial(super.isOnline);
}

class OnlineStatusToggled extends InquirerState {
  final bool newIsOnlineStatus;

  const OnlineStatusToggled(this.newIsOnlineStatus) : super(newIsOnlineStatus);
}

class HiringRequestFound extends InquirerState {
  const HiringRequestFound(super.isOnline);
}
