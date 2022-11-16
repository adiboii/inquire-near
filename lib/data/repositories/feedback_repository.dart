// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';

// Project imports:
import 'package:inquire_near/collections.dart';
import 'package:inquire_near/data/models/feedback.dart';

class FeedbackRepository {
  //final _currentUserEmail = FirebaseAuth.instance.currentUser!.email;
  Future submitFeedback({
    required String clientId,
    required String inquirerEmail,
    required int rating,
    String? review,
    required String transactionId,
  }) async {
    final feedbackDocument = FirebaseFirestore.instance
        .collection(feedbackCollection)
        .doc('transaction-id');
    final feedback = Feedback(
        // TODO: change to client and inquirer uid (MEL)
        clientId: 'test@gmail.com',
        inquirerId: inquirerEmail,
        rating: rating,
        review: review,
        transactionId: transactionId);
    await feedbackDocument.set(feedback.toJSON());
  }
}
