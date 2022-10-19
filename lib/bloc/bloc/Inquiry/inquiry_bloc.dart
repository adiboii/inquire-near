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
  final List<Inquiry> inquiries = [];

  InquiryBloc({required this.inquiryRepository}) : super(InquiryInProgress()) {
    on<CreateInquiryList>(_onCreateInquiryList);
    on<CreateInquiryRequested>(_onCreateInquiryRequested);
    on<AddInquiryRequested>(_onAddInquiryRequested);
    on<FinishInquiry>(_onFinishInquiry);
    on<RevisitInquiry>(_onRevisitInquiry);
  }

  Future<void> _onAddInquiryRequested(
      AddInquiryRequested event, Emitter<InquiryState> emit) async {
    emit(Loading());
    try {
      inquiries.add(event.inquiry);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> _onEditRequested(
      EditInquiryRequested event, Emitter<InquiryState> emit) async {
    emit(Loading());
    try {
      emit(InquiryInProgress());
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> _onCreateInquiryList(
      CreateInquiryList event, Emitter<InquiryState> emit) async {
    emit(Loading());
    try {
      inquiryList = event.inquiryList;
      await inquiryRepository.createInquiryList(inquiryList: inquiryList);
      emit(InquiryInProgress());
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> _onCreateInquiryRequested(
      CreateInquiryRequested event, Emitter<InquiryState> emit) async {
    emit(Loading());
    try {
      await inquiryRepository.createInquiry(nInquiry: event.inquiry);
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
}
