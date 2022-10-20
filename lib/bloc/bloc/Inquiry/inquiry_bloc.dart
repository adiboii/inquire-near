// Dart imports:
import 'dart:developer';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:inquire_near/screens/client/Edit_Inquiry_Screen/widgets/edit_inquiry_input.dart';
import 'package:meta/meta.dart';

// Project imports:
import 'package:inquire_near/data/models/inquiry.dart';
import 'package:inquire_near/data/models/inquiry_list.dart';
import 'package:inquire_near/data/repositories/inquiry_repository.dart';

part 'inquiry_event.dart';
part 'inquiry_state.dart';

class InquiryBloc extends Bloc<InquiryEvent, InquiryState> {
  final InquiryRepository inquiryRepository;
  late InquiryList inquiryList;
  List<Inquiry> inquiries = [];

  InquiryBloc({required this.inquiryRepository}) : super(InquiryInProgress()) {
    on<CreateInquiryList>(_onCreateInquiryList);
    on<AddInquiryRequested>(_onAddInquiryRequested);
    on<EditInquiryRequested>(_onEditInquiryRequested);
    on<DeleteInquiryRequested>(_onDeleteInquiryRequested);
    on<FinishInquiry>(_onFinishInquiry);
    on<RevisitInquiry>(_onRevisitInquiry);
    on<FinalizeInquiry>(_onFinalizeInquiry);
  }

  Future<void> _onCreateInquiryList(
      CreateInquiryList event, Emitter<InquiryState> emit) async {
    emit(CreatingInquiryList());
    try {
      inquiryList = event.inquiryList;
      await inquiryRepository.createInquiryList(inquiryList: inquiryList);
      emit(InquiryInProgress());
    } catch (e) {
      //TODO: error handling
      log(e.toString());
      emit(InquiryInProgress());
    }
  }

  Future<void> _onAddInquiryRequested(
      AddInquiryRequested event, Emitter<InquiryState> emit) async {
    emit(Loading());
    try {
      inquiries.add(event.inquiry);
      emit(InquiryInProgress());
    } catch (e) {
      //TODO: error handling
      log(e.toString());
      emit(InquiryInProgress());
    }
  }

  Future<void> _onEditInquiryRequested(
      EditInquiryRequested event, Emitter<InquiryState> emit) async {
    emit(Loading());
    try {
      inquiries[event.index] = event.editedInquiry;
      emit(InquiryInProgress());
    } catch (e) {
      //TODO: error handling
      log(e.toString());
      emit(InquiryInProgress());
    }
  }

  Future<void> _onDeleteInquiryRequested(
      DeleteInquiryRequested event, Emitter<InquiryState> emit) async {
    emit(Loading());
    try {
      inquiries.removeAt(event.index);
      emit(InquiryInProgress());
    } catch (e) {
      //TODO: error handling
      log(e.toString());
      emit(InquiryInProgress());
    }
  }

  Future<void> _onFinishInquiry(
      FinishInquiry event, Emitter<InquiryState> emit) async {
    emit(InquiryFinished());
  }

  Future<void> _onRevisitInquiry(
      RevisitInquiry event, Emitter<InquiryState> emit) async {
    emit(InquiryInProgress());
  }

  Future<void> _onFinalizeInquiry(
      FinalizeInquiry event, Emitter<InquiryState> emit) async {
    emit(Loading());
    try {
      for (Inquiry inquiry in inquiries) {
        if (inquiry.image != null) await inquiry.saveToFirebaseStorage();
        await inquiryRepository.createInquiry(inquiry: inquiry);
      }
      emit(InquiryFinished());
    } catch (e) {
      //TODO: error handling
      log(e.toString());
      emit(InquiryInProgress());
    }
  }
}
