import 'dart:io';

class Inquiry {
  Inquiry({this.message, this.requireProof, this.image});
  String? message;
  bool? requireProof;
  File? image;

  String? getInquiry() {
    return message;
  }

  bool? getRequireProof() {
    return requireProof;
  }

  File? getImage() {
    return image;
  }
}
