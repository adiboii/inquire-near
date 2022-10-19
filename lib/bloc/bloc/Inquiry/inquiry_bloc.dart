// Dart imports:
import 'dart:developer';
import 'dart:io';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:inquire_near/data/models/inquiry.dart';
import 'package:meta/meta.dart';

// Project imports:
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
    emit(Loading());
    try {
      inquiryList = event.inquiryList;
      await inquiryRepository.createInquiryList(inquiryList: inquiryList);
      log("Inquiry List ID: ${inquiryList.uid}");
      emit(InquiryInProgress());
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> _onAddInquiryRequested(
      AddInquiryRequested event, Emitter<InquiryState> emit) async {
    emit(Loading());
    try {
      inquiries.add(event.inquiry);
      emit(InquiryInProgress());
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> _onEditInquiryRequested(
      EditInquiryRequested event, Emitter<InquiryState> emit) async {
    emit(Loading());
    try {
      inquiries[event.index] = event.editedInquiry;
      emit(InquiryInProgress());
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> _onDeleteInquiryRequested(
      DeleteInquiryRequested event, Emitter<InquiryState> emit) async {
    emit(Loading());
    try {
      inquiries.removeAt(event.index);
      emit(InquiryInProgress());
    } catch (e) {
      log(e.toString());
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
      log(e.toString());
    }
  }
}
