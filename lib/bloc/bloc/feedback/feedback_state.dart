part of 'feedback_bloc.dart';

@immutable
abstract class FeedbackState extends Equatable {}

class FeedbackLoading extends FeedbackState {
  @override
  List<Object?> get props => [];
}

class FeedbackEmpty extends FeedbackState {
  @override
  List<Object?> get props => [];
}

class FeedbackSuccess extends FeedbackState {
  @override
  List<Object?> get props => [];
}

class FeedbackError extends FeedbackState {
  final String error;
  FeedbackError(this.error);
  @override
  List<Object?> get props => [];
}
