// Dart imports:
import 'dart:async';
import 'dart:developer';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';

// Project imports:
import 'package:inquire_near/data/models/inquiry.dart';
import 'package:inquire_near/data/models/inquiry_list.dart';

class InquiryRepository {
  final db = FirebaseFirestore.instance;

  Future<InquiryList?> createInquiryList(
      {required InquiryList inquiryList}) async {
    try {
      final DocumentReference doc =
          await db.collection("inquiryLists").add(inquiryList.toJSON());
      inquiryList.uid = doc.id;
      return inquiryList;
    } catch (e) {
      log(e.toString());
    }

    return null;
  }

  Future<void> finalizeInquiryList({required InquiryList inquiryList}) async {
    try {
      await db.collection("inquiryLists").doc(inquiryList.id).update({
        'noOfInquiries': inquiryList.noOfInquiries,
        'noOfRequireProof': inquiryList.noOfRequireProof,
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Future<String?> createInquiry({required Inquiry inquiry}) async {
    String? id;
    try {
      await db
          .collection("inquiries")
          .add(inquiry.toJSON())
          .then((DocumentReference docRef) {
        id = docRef.id;
        inquiry.inquiryUID = docRef.id;
      });
      return id;
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<void> setImageURL(
      {required String inquiryID, required String imageUrl}) async {
    try {
      await db
          .collection("inquiries")
          .doc(inquiryID)
          .update({'imageUrl': imageUrl});
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<Inquiry>> getInquiries(String inquiryListID) async {
    List<Inquiry> inquiries = [];

    QuerySnapshot<Map<String, dynamic>> inquiriesDoc = await FirebaseFirestore
        .instance
        .collection("inquiries")
        .where('inquiryListId', isEqualTo: inquiryListID)
        .get();

    for (var inquiry in inquiriesDoc.docs) {
      inquiries.add(Inquiry.fromJson(inquiry.data()));
    }
    return inquiries;
  }
}
