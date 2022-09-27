import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:inquire_near/data/models/inquiry.dart';
import 'package:inquire_near/data/repositories/inquiry_repository.dart';
import 'package:meta/meta.dart';

part 'inquiry_event.dart';
part 'inquiry_state.dart';

class InquiryBloc extends Bloc<InquiryEvent, InquiryState> {
  final InquiryRepository inquiryRepository;
  InquiryBloc({required this.inquiryRepository}) : super(InquiryInitial()) {
    on<CreateInquiryRequested>(_onAddInquiryFinished);
  }

  void _onAddInquiryFinished(
      CreateInquiryRequested event, Emitter<InquiryState> emit) {
    emit(Loading());
    try {
      inquiryRepository.addInquiry(inquiryList: event.inquiryList);
      emit(InquiryFinished());
    } catch (e) {
      log(e.toString());
    }
  }
}
