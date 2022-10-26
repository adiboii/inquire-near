part of 'report_bloc.dart';

abstract class ReportEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SubmitReportRequested extends ReportEvent {
  final String title;
  final String description;

  SubmitReportRequested(this.title, this.description);
}
