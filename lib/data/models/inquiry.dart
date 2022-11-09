// Dart imports:
import 'dart:developer';
import 'dart:io';

// Package imports:
import 'package:firebase_storage/firebase_storage.dart';

// Project imports:
import 'package:inquire_near/data/models/base_model.dart';

// ignore: must_be_immutable
class Inquiry extends BaseModel {
  // misc
  String inquiryListId;
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
    required this.inquiryListId,
    required this.question,
    required this.requireProof,
    this.image,
  }) : super();

  //json manipulations
  Inquiry.fromJson(Map<String, dynamic> json)
      : inquiryListId = json['inquiryListId'],
        question = json['question'],
        imageUrl = json['imageUrl'],
        requireProof = json['requireProof'];

  Map<String, dynamic> toJSON() => {
        'inquiryListId': inquiryListId,
        'question': question,
        'imageUrl': imageUrl,
        'requireProof': requireProof,
        'answerMessage': answerMessage,
        'answerImageUrl': answerImage,
        'dateTimeCreated': super.dateTimeCreated,
      };

  // getters
  String get withAttachedImages => image != null || imageUrl != null
      ? 'With Attachments'
      : 'No Attachements';

  // setters
  set inquiryUID(String uid) {
    this.uid = uid;
  }

  // helper functions
  Future<String?> saveToFirebaseStorage({required String inquiryId}) async {
    if (image != null) {
      try {
        var ref = FirebaseStorage.instance
            .ref()
            .child(inquiryListId)
            .child("${inquiryId}_inquiry_image");
        await ref.putFile(image!);
        imageUrl = await ref.getDownloadURL();
      } on FirebaseException catch (e) {
        log(e.toString());
      }
    }
    return imageUrl;
  }

  @override
  List<Object?> get props => throw UnimplementedError();
}
