// Dart imports:
import 'dart:developer';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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
    on<GetClientInquiries>(_onGetClientInquiries);
  }

  Future<void> _onCreateInquiryList(
      CreateInquiryList event, Emitter<InquiryState> emit) async {
    emit(CreatingInquiryList());
    try {
      inquiryList = (await inquiryRepository.createInquiryList(
          inquiryList: InquiryList()))!;
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
    String? inquiryID;
    String? imageUrl;
    try {
      for (Inquiry inquiry in inquiries) {
        inquiryID = await inquiryRepository.createInquiry(inquiry: inquiry);

        if (inquiry.image != null) {
          imageUrl = await inquiry.saveToFirebaseStorage(inquiryID: inquiryID!);
          await inquiryRepository.setImageURL(
              inquiryID: inquiryID, imageUrl: imageUrl!);
        }
      }
      emit(InquiryFinished());
    } catch (e) {
      //TODO: error handling
      log(e.toString());
      emit(InquiryInProgress());
    }
  }

  Future<void> _onGetClientInquiries(GetClientInquiries event, emit) async {
    emit(Loading());
    try {
      inquiries = await inquiryRepository.getInquiries(event.inquiryListID);
      emit(ClientInquiriesRetrieved());
    } catch (e) {
      //TODO: error handling
      log(e.toString());
      emit(ClientInquiriesRetrieved());
    }
  }
}
