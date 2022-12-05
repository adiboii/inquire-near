// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';

// Project imports:
import 'package:inquire_near/collections.dart';
import 'package:inquire_near/data/models/feedback.dart';

class FeedbackRepository {
  Future submitFeedback({
    required String clientId,
    required String inquirerId,
    required int rating,
    String? review,
    required String transactionId,
  }) async {
    final feedbackDocument =
        FirebaseFirestore.instance.collection(feedbackCollection);
    final feedback = Feedback(
        feedbacker: clientId,
        recepient: inquirerId,
        rating: rating,
        review: review,
        transactionId: transactionId);
    await feedbackDocument.add(feedback.toJSON());
  }
}
