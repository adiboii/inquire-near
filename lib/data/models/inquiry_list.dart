// Project imports:
import 'package:inquire_near/data/models/base_model.dart';

class InquiryList extends BaseModel {
  //TODO: add remaining properties to add inquiry module
  late String? id;
  int? noOfInquiries;
  int noOfRequireProof = 0;

  InquiryList({this.id}) : super();

  InquiryList.fromJson(Map<String, dynamic> json)
      : noOfInquiries = json['noOfInquiries'],
        noOfRequireProof = json['noOfRequireProof'];

  set uid(String uid) {
    id = uid;
  }

  Map<String, dynamic> toJSON() {
    return {
      "noOfInquiries": noOfInquiries,
      "noOfRequireProof": noOfRequireProof,
      "dateTimeCreated": super.dateTimeCreated,
    };
  }
}
