import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:inquire_near/data/models/in_user.dart';
import 'package:inquire_near/enums/role.dart';

part 'client_event.dart';
part 'client_state.dart';

class ClientBloc extends Bloc<ClientEvent, ClientState> {
  late Stream _availableInquirersStream;
  int counter = 0;

  ClientBloc() : super(ClientInitial()) {
    _availableInquirersStream = FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: Role.Inquirer.toString())
        .where('isActive', isEqualTo: true)
        .snapshots();

    on<FindAvailableInquirers>((event, emit) async {
      _availableInquirersStream.listen((ev) async {
        if (ev.docs.isNotEmpty || ev.docChanges.isNotEmpty) {
          add(EmitFindNewAvailableInquirers());
          List<INUser> inquirers = [];
          for (var doc in ev.docs) {
            INUser inquirer = INUser.fromJson(await doc.data());
            inquirer.setUID(doc.id);
            inquirers.add(inquirer);
          }
          add(GetAvailableInquirers(inquirers));
        } else if (ev.docs.isEmpty) {
          add(EmitNoAvailableInquirers());
        }
      });
    });

    on<EmitFindNewAvailableInquirers>((event, emit) {
      // Just emit an Empty() state to change the state for a moment
      // after finding new available inquirers.
      emit(Empty());
    });

    on<GetAvailableInquirers>((event, emit) async {
      if (event.inquirers.isEmpty) {
        emit(NoAvailableInquirersFound());
      } else {
        emit(NewAvailableInquirersFound(event.inquirers));
      }
    });

    on<EmitNoAvailableInquirers>((event, emit) {
      emit(NoAvailableInquirersFound());
    });
  }
}
