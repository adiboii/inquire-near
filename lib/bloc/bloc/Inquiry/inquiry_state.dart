part of 'inquiry_bloc.dart';

@immutable
abstract class InquiryState extends Equatable {
  const InquiryState();

  @override
  List<Object> get props => [];
}

class CreatingInquiryList extends InquiryState {}

class InquiryLoading extends InquiryState {}

class InquiryInProgress extends InquiryState {}

class InquiryFinished extends InquiryState {}

class ClientInquiriesRetrieved extends InquiryState {}

class InquiryDiscarded extends InquiryState {}

class AnsweredInquiry extends InquiryState {}

class AnsweringInquiryState extends InquiryState {}

class SavedInquiryAnswer extends InquiryState {}
