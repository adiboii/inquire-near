// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Project imports:
import 'package:inquire_near/data/models/report.dart';

class ReportRepository {
  //final _currentUserEmail = FirebaseAuth.instance.currentUser!.email;
  Future submitReport({
    required String title,
    required String description,
  }) async {
    // TODO: change 'transaction-id' to auto generated id
    final reportDocument =
        FirebaseFirestore.instance.collection('reports').doc('transaction-id');
    final report = Report(
      title: title,
      description: description,
    );
    await reportDocument.set(report.toJSON());
  }
}
