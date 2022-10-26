// Dart imports:
import 'dart:async';
import 'dart:developer';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:inquire_near/data/models/hiring_request.dart';
import 'package:inquire_near/data/models/in_user.dart';
import 'package:inquire_near/enums/hiring_request_status.dart';

part 'inquirer_event.dart';
part 'inquirer_state.dart';

class InquirerBloc extends Bloc<InquirerEvent, InquirerState> {
  bool isOnline = false; // Set default to false
  late StreamSubscription? _hiringRequestSubscription;
  HiringRequest? hiringRequest;

  InquirerBloc() : super(const InquirerInitial(false)) {
    //TODO: finish hiring request implementation
    // this is just to simulate getting a transaction doc
    hiringRequest = HiringRequest(
        clientId: "4Ltsqt5nyNZA4jfBv3ogQ68yyVg1",
        inquirerId: "hsF8cjt9DreKqy6fctdPrMBjdGI2",
        transactionId: "rNZ74JZFPx4wXyysOrnr",
        status: HiringRequestStatus.pending);
    hiringRequest!.setId("6H6SNAeBFdne0cB54ITF");
    on<Initial>((event, emit) async {
      DocumentSnapshot<Map<String, dynamic>> userDocument =
          await FirebaseFirestore.instance
              .collection("users")
              .doc("hsF8cjt9DreKqy6fctdPrMBjdGI2")
              .get();
      INUser inquirer = INUser.fromJson(userDocument.data()!);

      inquirer.isActive ??= false;

      emit(InquirerInitial(isOnline));

      if (isOnline != inquirer.isActive!) {
        isOnline = inquirer.isActive!;
        add(ToggleIsOnline(inquirer.isActive!));
      }
    });

    on<ToggleIsOnline>(_toggleIsOnline);

    on<NewHiringRequestFound>(_onNewHiringRequestFound);

    on<AcceptRequest>(_onAcceptRequest);

    on<RejectRequest>(_onRejectRequest);
  }

  void _toggleIsOnline(event, emit) async {
    isOnline = event.isOnline;

    emit(Empty()); // This is to trigger buildWhen()

    await FirebaseFirestore.instance
        .collection("users")
        .doc(
            "4Ltsqt5nyNZA4jfBv3ogQ68yyVg1") // TODO: Change to actual current logged in user
        .update({"isActive": isOnline}).onError(
            (e, _) => log("Error writing document: $e"));

    if (isOnline) {
      _hiringRequestSubscription = FirebaseFirestore.instance
          .collection('hiringRequests')
          .where('inquirerId',
              isEqualTo:
                  'hsF8cjt9DreKqy6fctdPrMBjdGI2') // TODO: Change actual inquirerId to currentUser
          .where('status', isEqualTo: HiringRequestStatus.pending.toValue())
          .orderBy("requestMade", descending: true)
          .snapshots()
          .listen((ev) async {
        if (ev.docs.isNotEmpty) {
          //TODO: clean up here, was commented out for simulation
          // Just get the latest HiringRequest data
          // HiringRequest hiringRequest =
          //     HiringRequest.fromJson(ev.docs[0].data());
          // hiringRequest.setId(ev.docs[0].id);

          add(NewHiringRequestFound(hiringRequest!));
        }
      });
    } else {
      // We try to stop subscription here to prevent overhead
      try {
        _hiringRequestSubscription?.cancel();
      } catch (e) {
        log("Stopping Request Subscription Error: ${e.toString()}");
      }
    }
  }

  void _onNewHiringRequestFound(event, emit) {
    hiringRequest = event.hiringRequest;
    emit(HiringRequestFound(hiringRequest!));
  }

  void _onAcceptRequest(event, emit) async {
    if (hiringRequest == null || hiringRequest?.id == null) return;
    await FirebaseFirestore.instance
        .collection('hiringRequests')
        .doc(hiringRequest?.id)
        .update({"status": HiringRequestStatus.accepted.toValue()});

    emit(AcceptedRequest());
  }

  void _onRejectRequest(event, emit) async {
    if (hiringRequest == null || hiringRequest?.id == null) return;
    await FirebaseFirestore.instance
        .collection('hiringRequests')
        .doc(hiringRequest?.id)
        .update({"status": HiringRequestStatus.rejected.toValue()});

    emit(RejectedRequest());
  }
}
