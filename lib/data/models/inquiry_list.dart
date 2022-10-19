// Project imports:
import 'package:inquire_near/data/models/base_model.dart';
import 'package:inquire_near/data/models/inquiry.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'enums.dart';

class InquiryList extends BaseModel {
  late String? uid;
  List<String> inquiryList = <String>[];

  InquiryList({this.uid}) : super();

  void setID(String uid) {
    this.uid = uid;
  }

  void add(String inquiryID) {
    inquiryList.add(inquiryID);
  }

  String getID() {
    return uid!;
  }

  Map<String, dynamic> toJSON() {
    return {
      "dateTimeCreated": super.dateTimeCreated,
    };
  }
}
