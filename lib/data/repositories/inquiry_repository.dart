import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:inquire_near/data/models/inquiry.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InquiryRepository {
  final db = FirebaseFirestore.instance;

  final user = FirebaseAuth.instance.currentUser!;

  Future<void> addInquiry({required List<Inquiry> inquiryList}) async {
    final inquiryDoc = <String, dynamic>{
      "ClientID": user.uid,
      "isCompleted": false,
      "Date": DateTime.now(),
      "Inquiries": inquiryList.map((inquiry) => inquiry.toJSON()).toList(),
    };

    try {
      await db.collection("transactions").add(inquiryDoc).then(
          (DocumentReference doc) =>
              log('DocumentSnapshot added with ID: ${doc.id}'));
    } catch (e) {
      log(e.toString());
    }
  }
}
