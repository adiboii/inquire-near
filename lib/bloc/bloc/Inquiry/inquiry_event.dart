part of 'inquiry_bloc.dart';

@immutable
abstract class InquiryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateInquiryList extends InquiryEvent {
  final InquiryList inquiryList;
  CreateInquiryList({required this.inquiryList});
}

class CreateInquiryRequested extends InquiryEvent {
  final Inquiry inquiry;
  CreateInquiryRequested({required this.inquiry});
}

class AddInquiryRequested extends InquiryEvent {
  final Inquiry inquiry;
  AddInquiryRequested({required this.inquiry});
}

class EditInquiryRequested extends InquiryEvent {
  final Inquiry inquiry;
  EditInquiryRequested({required this.inquiry});
}

class DeleteInquiryRequested extends InquiryEvent {
  final Inquiry inquiry;
  DeleteInquiryRequested({required this.inquiry});
}

class FinishInquiry extends InquiryEvent {
  FinishInquiry();
}

class RevisitInquiry extends InquiryEvent {
  RevisitInquiry();
}
