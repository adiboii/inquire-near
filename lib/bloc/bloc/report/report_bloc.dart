import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:inquire_near/data/repositories/report_repository.dart';

part 'report_event.dart';
part 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  final ReportRepository reportRepository;
  ReportBloc({required this.reportRepository}) : super(ReportEmpty()) {
    on<SubmitReportRequested>((event, emit) async {
      emit(ReportLoading());
      try {
        await reportRepository.submitReport(
          title: event.title,
          description: event.description,
        );
        emit(ReportSuccess());
      } catch (e) {
        emit(ReportError(e.toString()));
        emit(ReportEmpty());
      }
    });
  }
}