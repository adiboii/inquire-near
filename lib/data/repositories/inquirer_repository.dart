// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';

// Project imports:
import 'package:inquire_near/data/models/feedback.dart';
import 'package:inquire_near/data/models/in_user.dart';
import 'package:inquire_near/data/models/inquiry.dart';
import 'package:inquire_near/data/models/transaction.dart';

class InquirerRepository {
  Future<INTransaction> _getTransactionDetails(String transactionID) async {
    DocumentSnapshot<Map<String, dynamic>> transactionDoc =
        await FirebaseFirestore.instance
            .collection("transaction")
            .doc("rNZ74JZFPx4wXyysOrnr")
            .get();

    INTransaction transaction = INTransaction.fromJson(transactionDoc.data()!);

    return transaction;
  }

  Future<List<Inquiry>> _getInquiries(String inquiryListID) async {
    List<Inquiry> inquiries = [];

    QuerySnapshot<Map<String, dynamic>> inquiriesDoc = await FirebaseFirestore
        .instance
        .collection("inquiries")
        .where('inquiryListID', isEqualTo: inquiryListID)
        .get();

    for (var inquiry in inquiriesDoc.docs) {
      inquiries.add(Inquiry.fromJson(inquiry.data()));
    }

    return inquiries;
  }
}
