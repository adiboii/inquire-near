// Dart imports:
import 'dart:async';
import 'dart:developer';
import 'dart:io';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:inquire_near/data/models/inquiry.dart';

// Project imports:
import 'package:inquire_near/data/models/inquiry_list.dart';

class InquiryRepository {
  final db = FirebaseFirestore.instance;
  //final user = FirebaseAuth.instance.currentUser!;

  Future<void> createInquiry({required Inquiry nInquiry}) async {
    try {
      log("Trying to create inquiry object");
      await db
          .collection("inquiry")
          .add(nInquiry.instantiate())
          .then((DocumentReference docRef) => nInquiry.setInquiryID(docRef.id));
      log(nInquiry.getID());
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> saveInquiry({required Inquiry nInquiry}) async {
    try {
      await db.collection("inquiry").doc(nInquiry.uid).set(nInquiry.toJSON());
    } catch (e) {
      log(e.toString());
    }
  }

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

  Future<void> saveToFirebaseStorage(File image, String clientID,
      String inquiryID, String? downloadURL) async {
    try {
      var ref = FirebaseStorage.instance
          .ref()
          .child(clientID!)
          .child("${inquiryID}_inquiry_image");
      await ref.putFile(image);
      downloadURL = await ref.getDownloadURL();
      log("URL here: $downloadURL");
    } on FirebaseException catch (e) {
      log(e.toString());
    }
  }
}
