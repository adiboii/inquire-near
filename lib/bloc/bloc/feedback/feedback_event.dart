part of 'feedback_bloc.dart';

@immutable
abstract class FeedbackEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SubmitFeedbackRequested extends FeedbackEvent {
  final String inquirerEmail;
  final int rating;
  final String review;

  SubmitFeedbackRequested(this.inquirerEmail, this.rating, this.review);
}
