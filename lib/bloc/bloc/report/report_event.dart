part of 'report_bloc.dart';

abstract class ReportEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SubmitReportRequested extends ReportEvent {
  final String title;
  final String description;
  final String reporterId;
  final String recepientId;
  final String transactionId;

  SubmitReportRequested({
    required this.title,
    required this.description,
    required this.reporterId,
    required this.recepientId,
    required this.transactionId,
  });
}
