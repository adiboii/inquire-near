import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

// Don't mind this, still using it as reference
class InquiryN {
  InquiryN({this.message, this.requireProof, this.image});
  String? message;
  bool? requireProof;
  File? image;
  String imageUrl = '';
  String? getInquiry() {
    return message;
  }

  bool? getRequireProof() {
    return requireProof;
  }

  File? getImage() {
    return image;
  }

  Future<void> saveToFirebaseStorage(String uid) async {
    if (image != null) {
      try {
        var ref = FirebaseStorage.instance
            .ref()
            .child(uid)
            .child(DateTime.now().toString());
        await ref.putFile(image!);
        imageUrl = await ref.getDownloadURL();
      } on FirebaseException catch (e) {
        log(e.toString());
      }
    }
  }

  Map<String, dynamic> toJSON() {
    return {
      'inquiryMessage': message,
      'imageUrl': imageUrl,
      'requireProof': requireProof,
    };
  }
}

class Inquiry {
  late String? id;
  String question;
  bool requiresProof;
  File? image;
  String imageUrl = '';
  Map<String, dynamic>? answer;

  Inquiry({
    this.id,
    this.answer,
    this.image,
    required this.question,
    required this.requiresProof,
  });

  String? getInquiry() {
    return question;
  }

  bool? getRequireProof() {
    return requiresProof;
  }

  File? getImage() {
    return image;
  }

  int getAttachedImages() {
    if (image != null) return 1;
    return 0;
  }

  Map<String, dynamic> toJSON() {
    return {
      'inquiryMessage': question,
      'imageUrl': imageUrl,
      'requireProof': requiresProof,
    };
  }

  Future<void> saveToFirebaseStorage(String uid) async {
    if (image != null) {
      try {
        var ref = FirebaseStorage.instance
            .ref()
            .child(uid)
            .child(DateTime.now().toString());
        await ref.putFile(image!);
        imageUrl = await ref.getDownloadURL();
      } on FirebaseException catch (e) {
        log(e.toString());
      }
    }
  }
}
