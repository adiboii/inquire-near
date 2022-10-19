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
  bool requiresProof;
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
    required this.requiresProof,
    this.image,
  }) : super();

  //json manipulations
  Inquiry.fromJson(Map<String, dynamic> json)
      : inquiryListID = json['inquiryListID'],
        question = json['inquiryMessage'],
        requiresProof = json['requireProof'];

  Map<String, dynamic> toJSON() => {
        'inquiryListID': inquiryListID,
        'inquiryMessage': question,
        'imageUrl': imageUrl,
        'requireProof': requiresProof,
        'answerMessage': answerMessage,
        'answerImage': answerImage,
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
    return requiresProof;
  }

  String getURL() {
    return imageUrl!;
  }

  //setters
  void setInquiryID(String uid) {
    this.uid = uid;
  }

  void setInquiryListID(String uid) {
    inquiryListID = uid;
  }

  void setQuestion(String question) {
    this.question = question;
  }

  void setRequireProof(bool requiresProof) {
    this.requiresProof = requiresProof;
  }

  void setImage(File image) {
    this.image = image;
  }

  void setURL(String imageUrl) {
    this.imageUrl = imageUrl;
  }

  // helper functions
  Future<void> saveToFirebaseStorage() async {
    log("Trying to uplaod image");
    if (image != null) {
      try {
        var ref = FirebaseStorage.instance
            .ref()
            .child(uid!)
            .child("$uid" + "_inquiry_image");
        await ref.putFile(image!);
        imageUrl = await ref.getDownloadURL();
        log(imageUrl!);
      } on FirebaseException catch (e) {
        log(e.toString());
      }
    }
  }
}
