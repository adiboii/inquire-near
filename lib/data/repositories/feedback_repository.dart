// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';

// Project imports:
import 'package:inquire_near/data/models/feedback.dart';

class FeedbackRepository {
  //final _currentUserEmail = FirebaseAuth.instance.currentUser!.email;
  Future submitFeedback({
    required String inquirerEmail,
    required int rating,
    String? review,
  }) async {
    final feedbackDocument = FirebaseFirestore.instance
        .collection('feedbacks')
        .doc('transaction-id');
    final feedback = Feedback(
        // TODO: change to client and inquirer uid (MEL)
        clientId: 'test@gmail.com',
        inquirerId: inquirerEmail,
        rating: rating,
        review: review,
        transactionId: '');
    await feedbackDocument.set(feedback.toJSON());
  }
}
