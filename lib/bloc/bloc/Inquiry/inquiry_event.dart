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

class AddInquiryRequested extends InquiryEvent {
  final Inquiry inquiry;
  AddInquiryRequested({required this.inquiry});
}

class EditInquiryRequested extends InquiryEvent {
  final int index;
  final Inquiry editedInquiry;

  EditInquiryRequested({
    required this.index,
    required this.editedInquiry,
  });
}

class DeleteInquiryRequested extends InquiryEvent {
  final int index;
  DeleteInquiryRequested({required this.index});
}

class FinishInquiry extends InquiryEvent {
  FinishInquiry();
}

class RevisitInquiry extends InquiryEvent {
  RevisitInquiry();
}
