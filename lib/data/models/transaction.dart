// Dart imports:
import 'dart:developer';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';

// Project imports:
import 'package:inquire_near/data/models/base_model.dart';
import 'package:inquire_near/enums/paypal_status.dart';

class INTransaction extends BaseModel {
  String? id;
  final String clientID;
  String? inquirerID;
  final String inquiryListID;
  final String store; //TODO: update to StoreData
  final bool isCompleted;
  double? amount;
  String? payPalID;
  PayPalStatus? payPalStatus;
  Timestamp? dateTimeEnded;

  INTransaction({
    required this.clientID,
    required this.inquiryListID,
    required this.store,
    required this.isCompleted,
  }) : super();

  INTransaction.fromJson(Map<String, dynamic> json)
      : clientID = json['clientID'],
        inquirerID = json['inquirerID'],
        inquiryListID = json['inquiryListID'],
        store = json['store'],
        isCompleted = json['isCompleted'],
        amount = double.parse(json["amount"].toString()),
        payPalID = json['payPalID'],
        payPalStatus = getPayPalStatusFromString(json["payPalStatus"]);

  set uid(String id) {
    this.id = id;
  }

  void setAmount(int noOfInquiries, int noOfRequireProof) {
    amount = (noOfInquiries * 25) + (noOfRequireProof * 5);
  }

  Map<String, dynamic> toJSON() => {
        'clientID': clientID,
        'inquirerID': inquirerID,
        'inquiryListID': inquiryListID,
        'store': store,
        'amount': amount,
        'isCompleted': isCompleted,
        'dateTimeCreated': super.dateTimeCreated,
      };
}
