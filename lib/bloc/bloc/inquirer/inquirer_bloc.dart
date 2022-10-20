// Dart imports:
import 'dart:async';
import 'dart:developer';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:inquire_near/data/models/enums.dart';
import 'package:inquire_near/data/models/in_user.dart';

part 'inquirer_event.dart';
part 'inquirer_state.dart';

class InquirerBloc extends Bloc<InquirerEvent, InquirerState> {
  bool isOnline = false; // Set default to false
  late StreamSubscription? _hiringRequestSubscription;

  InquirerBloc() : super(const InquirerInitial(false)) {
    on<Initial>((event, emit) async {
      DocumentSnapshot<Map<String, dynamic>> userDocument =
          await FirebaseFirestore.instance
              .collection("users")
              .doc("hsF8cjt9DreKqy6fctdPrMBjdGI2")
              .get();
      INUser inquirer = INUser.fromJson(userDocument.data()!);

      inquirer.isActive ??= false;
      isOnline = inquirer.isActive!;
      emit(InquirerInitial(inquirer.isActive!));
    });

    on<ToggleIsOnline>(_toggleIsOnline);

    on<NewHiringRequestFound>(_onNewHiringRequestFound);
  }

  void _toggleIsOnline(event, emit) async {
    isOnline = !isOnline;

    await FirebaseFirestore.instance
        .collection("users")
        .doc(
            "hsF8cjt9DreKqy6fctdPrMBjdGI2") // TODO: Change to actual current logged in user
        .update({"isActive": isOnline}).onError(
            (e, _) => log("Error writing document: $e"));

    if (isOnline) {
      _hiringRequestSubscription = FirebaseFirestore.instance
          .collection('hiringRequests')
          .where('inquirerId',
              isEqualTo:
                  'hsF8cjt9DreKqy6fctdPrMBjdGI2') // TODO: Change actual inquirerId to currentUser
          .where('status', isEqualTo: HiringRequestStatus.pending.toValue())
          .snapshots()
          .listen((ev) async {
        if (ev.docs.isNotEmpty) {
          for (var doc in ev.docs) {
            log(doc.data().toString());
          }
          add(NewHiringRequestFound());
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
    emit(OnlineStatusToggled(isOnline));
  }

  void _onNewHiringRequestFound(event, emit) {
    emit(HiringRequestFound(isOnline));
  }
}
