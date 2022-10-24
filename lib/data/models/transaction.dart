import 'package:cloud_firestore/cloud_firestore.dart';

class INTransaction {
  late String? id;
  final String clientID;
  final String inquirerID;
  final String inquiryListID;
  final String store; //TODO: update to StoreData
  final bool isCompleted;
  final double amount;
  final String payPalID;
  final Timestamp dateTimeStarted;
  late Timestamp? dateTimeEnded;

  INTransaction(
      {this.id,
      required this.clientID,
      required this.inquirerID,
      required this.inquiryListID,
      required this.store,
      required this.isCompleted,
      required this.amount,
      required this.payPalID,
      required this.dateTimeStarted,
      this.dateTimeEnded});

  INTransaction.fromJson(Map<String, dynamic> json)
      : clientID = json['clientID'],
        inquirerID = json['inquirerID'],
        inquiryListID = json['inquiryListID'],
        store = json['store'],
        isCompleted = json['isCompleted'],
        amount = double.parse(json["amount"].toString()),
        payPalID = json['payPalID'],
        dateTimeStarted = json['dateTimeStarted'];

  set uid(String id) {
    this.id = id;
  }
}
