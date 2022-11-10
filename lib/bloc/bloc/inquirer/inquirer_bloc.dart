// Dart imports:
import 'dart:async';
import 'dart:developer';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:inquire_near/collections.dart';

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
    on<Initial>((event, emit) async {
      DocumentSnapshot<Map<String, dynamic>> userDocument =
          await FirebaseFirestore.instance
              .collection(userCollection)
              .doc(FirebaseAuth.instance.currentUser!.uid)
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

    final currentUser = FirebaseAuth.instance.currentUser!;

    emit(Empty()); // This is to trigger buildWhen()

    await FirebaseFirestore.instance
        .collection(userCollection)
        .doc(currentUser.uid)
        .update({"isActive": isOnline}).onError(
            (e, _) => log("Error writing document: $e"));

    if (isOnline) {
      _hiringRequestSubscription = FirebaseFirestore.instance
          .collection(hiringRequestCollection)
          .where('inquirerId', isEqualTo: currentUser.uid)
          .where('status', isEqualTo: HiringRequestStatus.pending.toValue())
          .orderBy("requestMade", descending: true)
          .snapshots()
          .listen((ev) async {
        if (ev.docs.isNotEmpty) {
          // Just get the latest HiringRequest data
          HiringRequest hiringRequest =
              HiringRequest.fromJson(ev.docs[0].data());
          hiringRequest.setId(ev.docs[0].id);

          add(NewHiringRequestFound(hiringRequest));
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
        .collection(hiringRequestCollection)
        .doc(hiringRequest?.id)
        .update({"status": HiringRequestStatus.accepted.toValue()});

    await FirebaseFirestore.instance
        .collection(transactionCollection)
        .doc(event.transactionId)
        .update({"inquirerId": FirebaseAuth.instance.currentUser!.uid});

    emit(AcceptedRequest());
  }

  void _onRejectRequest(event, emit) async {
    if (hiringRequest == null || hiringRequest?.id == null) return;
    await FirebaseFirestore.instance
        .collection(hiringRequestCollection)
        .doc(hiringRequest?.id)
        .update({"status": HiringRequestStatus.rejected.toValue()});

    emit(RejectedRequest());
  }
}
