import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inquire_near/data/models/inquiry_list.dart';

class InquiryRepository {
  final db = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser!;

  Future<void> addInquiry({required InquiryList inquiryList}) async {
    try {
      await db
          .collection("inquirylist")
          .add(inquiryList.toJSON())
          .then((DocumentReference doc) {
        inquiryList.setId(doc.id);
        log('InquiryList ID: ${doc.id}');
        log('DocumentSnapshot added with ID: ${doc.id}');
      });
    } catch (e) {
      log("$e here");
    }
  }
}
