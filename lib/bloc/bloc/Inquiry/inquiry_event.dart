part of 'inquiry_bloc.dart';

@immutable
abstract class InquiryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateInquiryRequested extends InquiryEvent {
  final InquiryList inquiryList;
  CreateInquiryRequested({required this.inquiryList});
}