import 'package:inquire_near/data/models/inquiry.dart';

import 'enums.dart';

class InquiryList {
  final String id;
  final String clientID;
  final List<Inquiry> list;
  final Store store;

  InquiryList(
      {required this.id,
      required this.clientID,
      required this.list,
      required this.store});
}
