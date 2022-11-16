part of 'inquiry_bloc.dart';

@immutable
abstract class InquiryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateInquiryList extends InquiryEvent {}

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

class DiscardInquiry extends InquiryEvent {}

class RevisitInquiry extends InquiryEvent {
  RevisitInquiry();
}

class FinalizeInquiry extends InquiryEvent {
  final INTransaction? transaction;

  FinalizeInquiry({this.transaction});
}

class GetClientInquiries extends InquiryEvent {
  final String inquiryListID;
  GetClientInquiries({required this.inquiryListID});
}
