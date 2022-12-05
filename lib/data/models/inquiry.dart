// Dart imports:
import 'dart:developer';
import 'dart:io';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

// Project imports:
import 'package:inquire_near/data/models/base_model.dart';

// ignore: must_be_immutable
class Inquiry extends BaseModel {
  // misc
  String? uid;

  // inquiry properties
  String? inquiryListId;
  String question;
  bool requireProof;
  File? image;
  String? imageUrl;
  Timestamp? timeCreated;

  // answer properties
  String? answerMessage;
  File? answerImage;
  String? answerImageUrl;

  //constructor
  Inquiry({
    this.uid,
    required this.question,
    required this.requireProof,
    this.image,
  }) : super();

  //json manipulations
  Inquiry.fromJson(Map<String, dynamic> json, String inquiryId)
      : inquiryListId = json['inquiryListId'],
        question = json['question'],
        imageUrl = json['imageUrl'],
        requireProof = json['requireProof'],
        answerMessage = json['answerMessage'],
        answerImageUrl = json['answerImageUrl'],
        timeCreated = json['dateTimeCreated'],
        uid = inquiryId;

  Map<String, dynamic> toJSON() => {
        'inquiryListId': inquiryListId,
        'question': question,
        'imageUrl': imageUrl,
        'requireProof': requireProof,
        'answerMessage': answerMessage,
        'answerImageUrl': answerImageUrl,
        'dateTimeCreated': super.dateTimeCreated,
      };

  // getters
  bool get withAttachedImages =>
      image != null || imageUrl != null ? true : false;

  String getUid() => uid!;

  // setters
  set inquiryUID(String uid) {
    this.uid = uid;
  }

  set answer(String answerMessage) {
    this.answerMessage = answerMessage;
  }

  set answerImg(File? answerImage) {
    this.answerImage = answerImage;
  }

  // helper functions
  Future<String?> saveToFirebaseStorage({required String inquiryId}) async {
    if (image != null) {
      try {
        var ref = FirebaseStorage.instance
            .ref()
            .child(inquiryListId!)
            .child("${inquiryId}_inquiry_image");
        await ref.putFile(image!);
        imageUrl = await ref.getDownloadURL();
      } on FirebaseException catch (e) {
        log(e.toString());
      }
    }
    return imageUrl;
  }

  Future<String?> saveAnswerToFirebaseStorage(
      {required String inquiryId}) async {
    if (answerImage != null) {
      try {
        Reference ref = FirebaseStorage.instance
            .ref()
            .child(inquiryListId!)
            .child("${inquiryId}_answer_image");
        await ref.putFile(answerImage!);
        answerImageUrl = await ref.getDownloadURL();
      } on FirebaseException catch (e) {
        log(e.toString());
      }
    }
    return answerImageUrl;
  }

  @override
  List<Object?> get props => throw UnimplementedError();
}
