// Project imports:
import 'package:inquire_near/data/models/enums.dart';

class Report {
  final String id;
  final String transactionID;
  final String title;
  final String description;
  final ReportType? reportType;

  Report({
    required this.id,
    required this.transactionID,
    required this.title,
    required this.description,
    this.reportType,
  });
}
