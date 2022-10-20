// Project imports:
import 'package:inquire_near/data/models/base_model.dart';

class InquiryList extends BaseModel {
  late String? uid;

  InquiryList({this.uid}) : super();

  set setID(String uid) {
    this.uid = uid;
  }

  Map<String, dynamic> toJSON() {
    return {
      "dateTimeCreated": super.dateTimeCreated,
    };
  }
}
