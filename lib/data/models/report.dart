// Project imports:
import 'package:inquire_near/data/models/enums.dart';

class Report {
  final String? id;
  final String? transactionId;
  final String title;
  final String description;
  final ReportType? reportType;

  Report({
    this.id,
    this.transactionId,
    required this.title,
    required this.description,
    this.reportType,
  });

  Map<String, dynamic> toJSON() => {
        'id': id,
        'transactionId': transactionId,
        'title': title,
        'description': description,
      };
}
