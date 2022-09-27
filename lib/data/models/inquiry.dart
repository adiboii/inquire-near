import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class Inquiry {
  Inquiry({this.message, this.requireProof, this.image});
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
