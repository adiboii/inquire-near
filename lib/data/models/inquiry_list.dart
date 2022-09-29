// Project imports:
import 'package:inquire_near/data/models/inquiry.dart';
import 'enums.dart';

class InquiryList {
  String? id;
  final String clientID;
  List<Inquiry> list;
  final Store store;

  InquiryList(
      {this.id,
      required this.clientID,
      required this.list,
      required this.store});

  void addInquiry(Inquiry inquiry) {
    list.add(inquiry);
  }

  int getListLength() {
    return list.length;
  }

  List<Inquiry> getList() {
    return list;
  }

  void setId(String id) {
    this.id = id;
  }

  Map<String, dynamic> toJSON() {
    return {
      "clientID": clientID,
      "inquiryList": list.map((inquiry) => inquiry.toJSON()).toList(),
      //TODO: need the store map here
      "store": store.toString(),
    };
  }
}
