// Dart imports:
import 'dart:async';
import 'dart:developer';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';

// Project imports:
import 'package:inquire_near/collections.dart';
import 'package:inquire_near/data/models/inquiry.dart';
import 'package:inquire_near/data/models/inquiry_list.dart';

class InquiryRepository {
  final db = FirebaseFirestore.instance;

  Future<InquiryList?> createInquiryList(
      {required InquiryList inquiryList}) async {
    try {
      final DocumentReference doc =
          await db.collection(inquiryListCollection).add(inquiryList.toJSON());
      inquiryList.uid = doc.id;
      return inquiryList;
    } catch (e) {
      log(e.toString());
    }

    return null;
  }

  Future<void> finalizeInquiryList({required InquiryList inquiryList}) async {
    try {
      await db.collection(inquiryListCollection).doc(inquiryList.id).update({
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
          .collection(inquiryCollection)
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

  Future<void> answerInquiry({
    required String inquiryId,
    required String answer,
    String? answerImageUrl,
  }) async {
    try {
      await db.collection(inquiryCollection).doc(inquiryId).update({
        'answerMessage': answer,
        'answerImageUrl': answerImageUrl,
      });
    } catch (e) {
      log("answerInquiry: ${e.toString()}");
    }
  }

  Future<void> setImageURL(
      {required String inquiryID, required String imageUrl}) async {
    try {
      await db
          .collection(inquiryCollection)
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
        .collection(inquiryCollection)
        .where('inquiryListId', isEqualTo: inquiryListID)
        .get();

    for (var inquiry in inquiriesDoc.docs) {
      inquiries.add(Inquiry.fromJson(inquiry.data(), inquiry.id));
    }
    inquiries.sort(
      ((a, b) => a.timeCreated!.toDate().compareTo(
            b.timeCreated!.toDate(),
          )),
    );
    return inquiries;
  }
}
