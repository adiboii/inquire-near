// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';

// Project imports:
import 'package:inquire_near/collections.dart';
import 'package:inquire_near/data/models/report.dart';

class ReportRepository {
  //final _currentUserEmail = FirebaseAuth.instance.currentUser!.email;
  Future submitReport({
    required String title,
    required String description,
    required String transactionId,
    required String reporterId,
    required String recepientId,
  }) async {
    // TODO: change 'transaction-id' to auto generated id (MEL)
    final reportDocument =
        FirebaseFirestore.instance.collection(reportCollection);
    final report = Report(
      title: title,
      description: description,
      recepientId: recepientId,
      reporterId: reporterId,
      transactionId: transactionId,
    );
    await reportDocument.add(report.toJSON());
  }
}
