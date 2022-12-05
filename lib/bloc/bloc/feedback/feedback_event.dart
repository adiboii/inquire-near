part of 'feedback_bloc.dart';

@immutable
abstract class FeedbackEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SubmitFeedbackRequested extends FeedbackEvent {
  final String feedbackerId;
  final String recepientId;
  final int rating;
  final String review;
  final String transactionId;

  SubmitFeedbackRequested(this.feedbackerId, this.recepientId, this.rating,
      this.review, this.transactionId);
}
