// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';

// Project imports:
import 'package:inquire_near/constants.dart';
import 'package:inquire_near/data/models/base_model.dart';
import 'package:inquire_near/enums/paypal_status.dart';

// ignore: must_be_immutable
class INTransaction extends BaseModel {
  String? id;
  final String clientId;
  String? inquirerId;
  final String inquiryListId;
  final String store; //TODO: update to StoreData (ADI)
  final bool isCompleted;
  double? amount;
  String? payPalId;
  PayPalStatus? payPalStatus;
  Timestamp? dateTimeEnded;

  INTransaction({
    required this.clientId,
    required this.inquiryListId,
    required this.store,
    required this.isCompleted,
  }) : super();

  INTransaction.fromJson(Map<String, dynamic> json)
      : clientId = json['clientId'],
        inquirerId = json['inquirerId'],
        inquiryListId = json['inquiryListId'],
        store = json['store'],
        isCompleted = json['isCompleted'],
        amount = double.parse(json["amount"].toString()),
        payPalId = json['payPalId'],
        payPalStatus = getPayPalStatusFromString(json["payPalStatus"]),
        dateTimeEnded = json['dateTimeEnded'];

  set uid(String id) {
    this.id = id;
  }

  static INTransaction setDataAndId(Map<String, dynamic> json, String id) {
    INTransaction transaction = INTransaction.fromJson(json);
    transaction.uid = id;
    return transaction;
  }

  void setAmount(int noOfInquiries, int noOfRequireProof) {
    amount =
        (noOfInquiries * inquiryPrice) + (noOfRequireProof * requireProofPrice);
  }

  Map<String, dynamic> toJSON() => {
        'clientId': clientId,
        'inquirerId': inquirerId,
        'inquiryListId': inquiryListId,
        'store': store,
        'amount': amount,
        'isCompleted': isCompleted,
        'dateTimeCreated': super.dateTimeCreated,
      };

  @override
  List<Object?> get props => [];
}
