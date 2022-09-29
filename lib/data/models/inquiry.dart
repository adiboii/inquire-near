import 'dart:developer';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

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
