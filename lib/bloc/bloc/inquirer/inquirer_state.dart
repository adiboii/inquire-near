part of 'inquirer_bloc.dart';

abstract class InquirerState extends Equatable {
  final bool? isOnline;
  const InquirerState([this.isOnline]);

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
  final HiringRequest hiringRequest;

  const HiringRequestFound(this.hiringRequest);
}

class AcceptedRequest extends InquirerState {}

class RejectedRequest extends InquirerState {}

class Empty extends InquirerState {}

class RetrievedHiringDetails extends InquirerState {
  // This data is composed of different statistics, not only `user`
  final Map<String, dynamic> data;

  const RetrievedHiringDetails(this.data);
}
