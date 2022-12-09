// Dart imports:
import 'dart:developer';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';

// Project imports:
import 'package:inquire_near/collections.dart';
import 'package:inquire_near/data/models/feedback.dart';
import 'package:inquire_near/data/models/in_user.dart';
import 'package:inquire_near/data/models/transaction.dart';
import 'package:inquire_near/data/repositories/transaction_repository.dart';
import 'package:inquire_near/enums/role.dart';

class UserRepository {
  Future<INUser> getUser(String userId) async {
    DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await FirebaseFirestore.instance
            .collection(userCollection)
            .doc(userId)
            .get();
    Map<String, dynamic> userData = userSnapshot.data()!;
    INUser user = INUser.fromJson(userData);
    user.setUID(userSnapshot.id);

    // TODO: Add this on `INUser.fromJSON()` after cleaning database
    user.setPayPalAddress(userData["paypalAddress"]);

    return user;
  }

  Future<int> _getUserInquiriesCount(String userId) async {
    QuerySnapshot<Map<String, dynamic>> inquiries = await FirebaseFirestore
        .instance
        .collection(inquiryListCollection)
        .where('clientId', isEqualTo: userId)
        .get();

    return inquiries.docs.length;
  }

  Future<Map<String, dynamic>> getUserData(String userId) async {
    QuerySnapshot<Map<String, dynamic>> feedbackDocs = await FirebaseFirestore
        .instance
        .collection(feedbackCollection)
        .where('recepientId', isEqualTo: userId)
        .get();

    List<Map<String, Feedback>> feedbacks = [];

    double ratingSum = 0;
    for (var element in feedbackDocs.docs) {
      Feedback feedback = Feedback.fromJson(element.data());

      // Get transaction of feedback
      INTransaction t = await TransactionRepository()
          .getTransactionDetails(feedback.transactionId);
      if (userId != t.inquirerId) {
        continue;
      }

      // Get User to get first name of client
      INUser client = await getUser(element["feedbackerId"]);

      feedbacks.add({client.firstName!: feedback});

      ratingSum += element["rating"];
    }
    double ratingAverage = ratingSum / feedbackDocs.docs.length;

    Map<String, dynamic> computedFeedbackMap = {
      "user": await getUser(userId),
      "feedbacks": feedbacks,
      "numberOfFeedbacks": feedbackDocs.docs.length,
      "averageRating": ratingAverage,
      "numberOfInquiries": await _getUserInquiriesCount(userId)
    };

    return computedFeedbackMap;
  }

  Future<void> switchRole(
      {required String id, required Role roleToSwitch}) async {
    try {
      await FirebaseFirestore.instance
          .collection(userCollection)
          .doc(id)
          .update({"role": roleToSwitch.toValue()});
    } catch (e) {
      log(e.toString());
    }
  }
}
