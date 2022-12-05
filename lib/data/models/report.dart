// Project imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inquire_near/data/models/enums.dart';

class Report {
  final String? transactionId;
  final String title;
  final String description;
  final ReportType? reportType;
  final String? reporterId;
  final String? recepientId;

  Report({
    this.transactionId,
    required this.title,
    required this.description,
    this.reportType,
    this.recepientId,
    this.reporterId,
  });

  Map<String, dynamic> toJSON() {
    var dateTimeCreated = Timestamp.now();
    return {
      'transactionId': transactionId,
      'title': title,
      'description': description,
      'reporterId': reporterId,
      'recepientId': recepientId,
      'dateTimeCreated': dateTimeCreated,
    };
  }
}
