// Dart imports:
import 'dart:async';
import 'dart:developer';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Project imports:
import 'package:inquire_near/data/models/inquiry.dart';
import 'package:inquire_near/data/models/inquiry_list.dart';

class InquiryRepository {
  final db = FirebaseFirestore.instance;

  Future<void> createInquiryList({required InquiryList inquiryList}) async {
    try {
      await db
          .collection("inquiryList")
          .add(inquiryList.toJSON())
          .then((DocumentReference docRef) => inquiryList.uid = docRef.id);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> createInquiry({required Inquiry inquiry}) async {
    try {
      await db
          .collection("inquiry")
          .add(inquiry.toJSON())
          .then((DocumentReference docRef) => inquiry.inquiryUID = docRef.id);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<Inquiry>> getInquiries(String inquiryListID) async {
    List<Inquiry> inquiries = [];

    QuerySnapshot<Map<String, dynamic>> inquiriesDoc = await FirebaseFirestore
        .instance
        .collection("inquiry")
        .where('inquiryListID', isEqualTo: inquiryListID)
        .get();

    for (var inquiry in inquiriesDoc.docs) {
      inquiries.add(Inquiry.fromJson(inquiry.data()));
    }

    return inquiries;
  }
}
