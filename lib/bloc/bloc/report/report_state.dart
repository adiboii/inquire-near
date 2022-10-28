part of 'report_bloc.dart';

abstract class ReportState extends Equatable {}

class ReportLoading extends ReportState {
  @override
  List<Object?> get props => [];
}

class ReportEmpty extends ReportState {
  @override
  List<Object?> get props => [];
}

class ReportSuccess extends ReportState {
  @override
  List<Object?> get props => [];
}

class ReportError extends ReportState {
  final String error;
  ReportError(this.error);
  @override
  List<Object?> get props => [];
}
