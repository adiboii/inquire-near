// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:inquire_near/data/repositories/feedback_repository.dart';

part 'feedback_event.dart';
part 'feedback_state.dart';

class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {
  final FeedbackRepository feedbackRepository;
  FeedbackBloc({required this.feedbackRepository}) : super(FeedbackEmpty()) {
    on<SubmitFeedbackRequested>((event, emit) async {
      emit(FeedbackLoading());
      try {
        await feedbackRepository.submitFeedback(
          inquirerEmail: event.inquirerEmail,
          rating: event.rating,
          review: event.review,
        );
        emit(FeedbackSuccess());
      } catch (e) {
        emit(FeedbackError(e.toString()));
        emit(FeedbackEmpty());
      }
    });
  }
}
