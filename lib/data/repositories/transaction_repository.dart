import 'package:cloud_firestore/cloud_firestore.dart';

// Project imports:
import 'package:inquire_near/data/models/in_user.dart';
import 'package:inquire_near/data/models/inquiry_list.dart';
import 'package:inquire_near/data/models/transaction.dart';

class TransactionRepository {
  Future<INTransaction> getTransactionDetails(String transactionID) async {
    DocumentSnapshot<Map<String, dynamic>> transactionDoc =
        await FirebaseFirestore.instance
            .collection("transaction")
            .doc(transactionID)
            .get();

    INTransaction transaction = INTransaction.fromJson(transactionDoc.data()!);

    return transaction;
  }

  Future<INUser> getClientData(String userID) async {
    DocumentSnapshot<Map<String, dynamic>> user =
        await FirebaseFirestore.instance.collection("users").doc(userID).get();
    INUser userData = INUser.fromJson(user.data()!);

    return userData;
  }

  Future<InquiryList> getInquiryList(String inquiryListID) async {
    DocumentSnapshot<Map<String, dynamic>> inquiryListDoc =
        await FirebaseFirestore.instance
            .collection("inquiryList")
            .doc(inquiryListID)
            .get();

    InquiryList inquiryList = InquiryList.fromJson(inquiryListDoc.data()!);

    return inquiryList;
  }
}
