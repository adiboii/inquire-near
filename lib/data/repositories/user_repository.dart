// Dart imports:
import 'dart:developer';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';

// Project imports:
import 'package:inquire_near/data/models/feedback.dart';
import 'package:inquire_near/data/models/in_user.dart';
import 'package:inquire_near/enums/role.dart';

class UserRepository {
  Future<INUser> getUser(String userId) async {
    DocumentSnapshot<Map<String, dynamic>> user =
        await FirebaseFirestore.instance.collection("users").doc(userId).get();
    INUser userData = INUser.fromJson(user.data()!);
    userData.setUID(userId);
    return userData;
  }

  Future<int> _getUserInquiriesCount(String userId) async {
    QuerySnapshot<Map<String, dynamic>> inquiries = await FirebaseFirestore
        .instance
        .collection("inquiryList")
        .where('clientId', isEqualTo: userId)
        .get();

    return inquiries.docs.length;
  }

  Future<Map<String, dynamic>> getUserData(String userId) async {
    QuerySnapshot<Map<String, dynamic>> feedbackDocs = await FirebaseFirestore
        .instance
        .collection("feedbacks")
        .where('inquirerId', isEqualTo: userId)
        .get();

    List<Map<String, Feedback>> feedbacks = [];

    double ratingSum = 0;
    for (var element in feedbackDocs.docs) {
      Feedback feedback = Feedback.fromJson(element.data());

      // Get User to get first name of client
      INUser client = await getUser(element["clientId"]);

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
          .collection('users')
          .doc(id)
          .update({"role": roleToSwitch.toValue()});
    } catch (e) {
      log(e.toString());
    }
  }
}
