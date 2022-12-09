// Project imports:
import 'package:inquire_near/data/models/base_model.dart';

// ignore: must_be_immutable
class InquiryList extends BaseModel {
  late String? id;
  int noOfInquiries = 0;
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

  @override
  List<Object?> get props => throw UnimplementedError();
}
