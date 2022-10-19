// Dart imports:
import 'dart:async';
import 'dart:developer';
import 'dart:io';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:inquire_near/data/models/inquiry.dart';

// Project imports:
import 'package:inquire_near/data/models/inquiry_list.dart';

class InquiryRepository {
  final db = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser!;

  Future<void> createInquiryList({required InquiryList inquiryList}) async {
    try {
      await db
          .collection("inquiryList")
          .add(inquiryList.toJSON())
          .then((DocumentReference docRef) => inquiryList.setID(docRef.id));
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> createInquiry({required Inquiry inquiry}) async {
    try {
      log("Trying to create inquiry object");
      await db
          .collection("inquiry")
          .add(inquiry.toJSON())
          .then((DocumentReference docRef) => inquiry.setInquiryID(docRef.id));
      log(inquiry.getID());
    } catch (e) {
      log(e.toString());
    }
  }
}
