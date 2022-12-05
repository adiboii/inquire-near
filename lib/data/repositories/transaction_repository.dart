// Dart imports:
import 'dart:developer';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';

// Project imports:
import 'package:inquire_near/collections.dart';
import 'package:inquire_near/data/models/in_user.dart';
import 'package:inquire_near/data/models/inquiry_list.dart';
import 'package:inquire_near/data/models/transaction.dart';
import 'package:inquire_near/enums/role.dart';

class TransactionRepository {
  Future<String?> createTransactionAndGetId(
      {required INTransaction transaction}) async {
    DocumentReference transactionRef = await FirebaseFirestore.instance
        .collection(transactionCollection)
        .add(transaction.toJSON());

    return transactionRef.id;
  }

  Future<INTransaction> getTransactionDetails(String transactionId) async {
    DocumentSnapshot<Map<String, dynamic>> transactionDoc =
        await FirebaseFirestore.instance
            .collection(transactionCollection)
            .doc(transactionId)
            .get();
    INTransaction transaction = INTransaction.fromJson(transactionDoc.data()!);
    transaction.id = transactionDoc.id;
    return transaction;
  }

  Future<INUser> getUserData(String userId) async {
    DocumentSnapshot<Map<String, dynamic>> user = await FirebaseFirestore
        .instance
        .collection(userCollection)
        .doc(userId)
        .get();
    INUser userData = INUser.fromJson(user.data()!);

    return userData;
  }

  Future<InquiryList> getInquiryList(String inquiryListId) async {
    DocumentSnapshot<Map<String, dynamic>> inquiryListDoc =
        await FirebaseFirestore.instance
            .collection(inquiryListCollection)
            .doc(inquiryListId)
            .get();

    InquiryList inquiryList = InquiryList.fromJson(inquiryListDoc.data()!);

    return inquiryList;
  }

  Future<QuerySnapshot> getTransactionsFromUser(
      String userId, bool isCompleted) async {
    QuerySnapshot q = await FirebaseFirestore.instance
        .collection(transactionCollection)
        .where('inquirerId', isEqualTo: userId)
        .where('isCompleted', isEqualTo: isCompleted)
        .get();

    return q;
  }

  Future<List<INTransaction>> getRecentTransactions(
      String userId, Role role) async {
    List<INTransaction> transactionList = [];
    QuerySnapshot<Map<String, dynamic>> transactions;

    if (role == Role.client) {
      transactions = await FirebaseFirestore.instance
          .collection(transactionCollection)
          .where('clientId', isEqualTo: userId)
          .where('isCompleted', isEqualTo: true)
          .orderBy('dateTimeEnded', descending: true)
          .limit(5)
          .get();
    } else {
      transactions = await FirebaseFirestore.instance
          .collection(transactionCollection)
          .where('inquirerId', isEqualTo: userId)
          .where('isCompleted', isEqualTo: true)
          .orderBy('dateTimeEnded', descending: true)
          .limit(5)
          .get();
    }

    for (var transaction in transactions.docs) {
      transactionList
          .add(INTransaction.setDataAndId(transaction.data(), transaction.id));
    }

    return transactionList;
  }

  Future<void> completeTransaction(String transactionId) async {
    try {
      await FirebaseFirestore.instance
          .collection(transactionCollection)
          .doc(transactionId)
          .update({"isCompleted": true, "dateTimeEnded": Timestamp.now()});
    } catch (e) {
      log("completeTransaction() error > $e");
    }
  }
}
