// Dart imports:
import 'dart:developer';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

// Project imports:
import 'package:inquire_near/collections.dart';
import 'package:inquire_near/data/models/inquiry.dart';
import 'package:inquire_near/data/models/inquiry_list.dart';
import 'package:inquire_near/data/models/transaction.dart';
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
    on<DiscardInquiry>(_onDiscardInquiry);
    on<AnswerInquiryRequested>(_onAnswerInquiry);
    on<ClearInquiry>(_onClearInquiry);
    on<AnswerInquiry>(_onAnswerOneInquiry);
    on<AnsweringInquiry>(_onAnsweringInquiry);
  }

  void _onAnswerOneInquiry(
      AnswerInquiry event, Emitter<InquiryState> emit) async {
    emit(AnsweredInquiry());
  }

  void _onAnsweringInquiry(
      AnsweringInquiry event, Emitter<InquiryState> emit) async {
    emit(AnsweringInquiryState());
  }

  Future<void> _onAnswerInquiry(
      AnswerInquiryRequested event, Emitter<InquiryState> emit) async {
    try {
      inquiries = event.inquiryList;
      for (Inquiry inquiry in inquiries) {
        final answerImgUrl =
            await inquiry.saveAnswerToFirebaseStorage(inquiryId: inquiry.uid!);
        await inquiryRepository.answerInquiry(
          inquiryId: inquiry.uid!,
          answer: inquiry.answerMessage!,
          answerImageUrl: answerImgUrl,
        );
      }
      emit(SavedInquiryAnswer());
    } catch (e) {
      log("onAnswerInquiry: ${e.toString()}");
    }
  }

  Future<void> _onCreateInquiryList(
      CreateInquiryList event, Emitter<InquiryState> emit) async {
    emit(CreatingInquiryList());
    try {
      inquiryList = (await inquiryRepository.createInquiryList(
          inquiryList: InquiryList()))!;
      emit(InquiryInProgress());
    } catch (e) {
      log("Error on _onCreateInquiryList: $e");
      emit(InquiryInProgress());
    }
  }

  Future<void> _onAddInquiryRequested(
      AddInquiryRequested event, Emitter<InquiryState> emit) async {
    emit(InquiryLoading());
    try {
      inquiries.add(event.inquiry);
      emit(InquiryInProgress());
    } catch (e) {
      log("Error on _onAddInquiryRequested: $e");
      emit(InquiryInProgress());
    }
  }

  Future<void> _onEditInquiryRequested(
      EditInquiryRequested event, Emitter<InquiryState> emit) async {
    emit(InquiryLoading());
    try {
      inquiries[event.index] = event.editedInquiry;
      emit(InquiryInProgress());
    } catch (e) {
      log("Error on _onEditInquiryRequested: $e");
      emit(InquiryInProgress());
    }
  }

  Future<void> _onDeleteInquiryRequested(
      DeleteInquiryRequested event, Emitter<InquiryState> emit) async {
    emit(InquiryLoading());
    try {
      inquiries.removeAt(event.index);
      emit(InquiryInProgress());
    } catch (e) {
      log("Error on _onDeleteInquiryRequested: $e");
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
    emit(InquiryLoading());
    String? inquiryID;
    String? imageUrl;
    if (event.transaction != null) {
      await _createNewInquiryList(event.transaction);
    }

    try {
      inquiryList.noOfInquiries = inquiries.length;
      for (Inquiry inquiry in inquiries) {
        inquiry.inquiryListId = inquiryList.id;
        if (inquiry.requireProof == true) {
          inquiryList.noOfRequireProof++;
        }

        inquiryID = await inquiryRepository.createInquiry(inquiry: inquiry);
        inquiry.uid = inquiryID;

        if (inquiry.image != null) {
          imageUrl = await inquiry.saveToFirebaseStorage(inquiryId: inquiryID!);
          await inquiryRepository.setImageURL(
              inquiryID: inquiryID, imageUrl: imageUrl!);
        }
      }
      await inquiryRepository.finalizeInquiryList(inquiryList: inquiryList);

      emit(InquiryFinished());
    } catch (e) {
      log("Error on _onAddInquiryRequestd: $e");
      emit(InquiryInProgress());
    }
  }

  Future<void> _onGetClientInquiries(GetClientInquiries event, emit) async {
    emit(InquiryLoading());
    try {
      inquiries = await inquiryRepository.getInquiries(event.inquiryListID);
      emit(ClientInquiriesRetrieved());
    } catch (e) {
      log("Error on _onGetClientInquiries: $e");
      emit(ClientInquiriesRetrieved());
    }
  }

  Future<void> _createNewInquiryList(INTransaction? transaction) async {
    for (Inquiry inquiry in inquiries) {
      await FirebaseFirestore.instance
          .collection(inquiryCollection)
          .doc(inquiry.uid)
          .delete();
    }

    await FirebaseFirestore.instance
        .collection(inquiryCollection)
        .doc(inquiryList.id)
        .delete();

    await FirebaseFirestore.instance
        .collection(transactionCollection)
        .doc(transaction!.id)
        .delete();

    try {
      inquiryList = (await inquiryRepository.createInquiryList(
          inquiryList: InquiryList()))!;
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> _onDiscardInquiry(event, Emitter<InquiryState> emit) async {
    emit(InquiryLoading());
    inquiries = [];
    await FirebaseFirestore.instance
        .collection(inquiryCollection)
        .doc(inquiryList.id)
        .delete();

    emit(InquiryDiscarded());
  }

  void _onClearInquiry(event, emit) {
    inquiries = [];
  }
}
