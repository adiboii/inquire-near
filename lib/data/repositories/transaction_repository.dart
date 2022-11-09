// Package imports:
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

// Project imports:
import 'package:inquire_near/data/models/in_user.dart';
import 'package:inquire_near/data/models/inquiry_list.dart';
import 'package:inquire_near/data/models/transaction.dart';

class TransactionRepository {
  Future<String?> createTransactionAndGetId(
      {required INTransaction transaction}) async {
    DocumentReference transactionRef = await FirebaseFirestore.instance
        .collection("transactions")
        .add(transaction.toJSON());

    return transactionRef.id;
  }

  Future<INTransaction> getTransactionDetails(String transactionId) async {
    DocumentSnapshot<Map<String, dynamic>> transactionDoc =
        await FirebaseFirestore.instance
            .collection("transactions")
            .doc(transactionId)
            .get();

    log(transactionDoc.toString());
    INTransaction transaction = INTransaction.fromJson(transactionDoc.data()!);

    return transaction;
  }

  Future<INUser> getClientData(String userId) async {
    DocumentSnapshot<Map<String, dynamic>> user =
        await FirebaseFirestore.instance.collection("users").doc(userId).get();
    INUser userData = INUser.fromJson(user.data()!);

    return userData;
  }

  Future<InquiryList> getInquiryList(String inquiryListId) async {
    DocumentSnapshot<Map<String, dynamic>> inquiryListDoc =
        await FirebaseFirestore.instance
            .collection("inquiryLists")
            .doc(inquiryListId)
            .get();

    InquiryList inquiryList = InquiryList.fromJson(inquiryListDoc.data()!);

    return inquiryList;
  }
}
