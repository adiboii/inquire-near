// Dart imports:
import 'dart:developer';
import 'dart:io';

// Package imports:
import 'package:firebase_storage/firebase_storage.dart';
import 'package:inquire_near/data/models/base_model.dart';

class Inquiry extends BaseModel {
  // misc
  String inquiryListID;
  String? uid;

  // inquiry properties
  String question;
  bool requireProof;
  File? image;
  String? imageUrl;

  // answer properties
  String? answerMessage;
  File? answerImage;
  String? answerImageUrl;

  //constructor
  Inquiry({
    this.uid,
    required this.inquiryListID,
    required this.question,
    required this.requireProof,
    this.image,
  }) : super();

  //json manipulations
  Inquiry.fromJson(Map<String, dynamic> json)
      : inquiryListID = json['inquiryListID'],
        question = json['inquiryMessage'],
        requireProof = json['requireProof'];

  Map<String, dynamic> toJSON() => {
        'inquiryListID': inquiryListID,
        'question': question,
        'imageUrl': imageUrl,
        'requireProof': requireProof,
        'answerMessage': answerMessage,
        'answerImageUrl': answerImage,
        'dateTimeCreated': super.dateTimeCreated,
      };

  // getters
  String getID() {
    return uid ?? '';
  }

  String getInquiryListID() {
    return inquiryListID;
  }

  String? getInquiry() {
    return question;
  }

  int numOfImagesAttached() {
    if (image != null) return 1;
    return 0;
  }

  bool getRequireProof() {
    return requireProof;
  }

  String getURL() {
    return imageUrl!;
  }

  //setters
  void setInquiryID(String uid) {
    this.uid = uid;
  }

  // helper functions
  Future<void> saveToFirebaseStorage() async {
    log("Trying to uplaod image");
    if (image != null) {
      try {
        var ref = FirebaseStorage.instance
            .ref()
            .child('client_id')
            .child("inquiry_id" + "_inquiry_image");
        await ref.putFile(image!);
        imageUrl = await ref.getDownloadURL();
        log(imageUrl!);
      } on FirebaseException catch (e) {
        log(e.toString());
      }
    }
  }
}
