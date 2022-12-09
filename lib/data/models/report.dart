// Project imports:
import 'package:inquire_near/data/models/base_model.dart';

//ignore: must_be_immutable
class Report extends BaseModel {
  final String? transactionId;
  final String title;
  final String description;
  final String? reporterId;
  final String? recepientId;

  Report({
    this.transactionId,
    required this.title,
    required this.description,
    this.recepientId,
    this.reporterId,
  }) : super();

  Map<String, dynamic> toJSON() {
    return {
      'transactionId': transactionId,
      'title': title,
      'description': description,
      'reporterId': reporterId,
      'recepientId': recepientId,
      'dateTimeCreated': super.dateTimeCreated,
    };
  }

  @override
  List<Object?> get props => [];
}
