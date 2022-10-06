part of 'inquiry_bloc.dart';

@immutable
abstract class InquiryState extends Equatable {}

class InquiryInitial extends InquiryState {
  @override
  List<Object?> get props => [];
}

class Loading extends InquiryState {
  @override
  List<Object?> get props => [];
}

class InquiryFinished extends InquiryState {
  @override
  List<Object?> get props => [];
}
