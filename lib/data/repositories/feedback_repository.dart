import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/feedback.dart';

class FeedbackRepository {
  final _currentUserEmail = FirebaseAuth.instance.currentUser!.email;
  Future submitFeedback({
    required String inquirerEmail,
    required int rating,
    String? review,
  }) async {
    final feedbackDocument = FirebaseFirestore.instance
        .collection('feedbacks')
        .doc('transaction-id');
    final feedback = Feedback(
      clientEmail: _currentUserEmail!,
      inquirerEmail: inquirerEmail,
      rating: rating,
      review: review,
    );
    await feedbackDocument.set(feedback.toJSON());
  }
}
