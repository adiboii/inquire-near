// Dart imports:
import 'dart:async';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:inquire_near/data/models/hiring_request.dart';
import 'package:inquire_near/data/models/in_user.dart';
import 'package:inquire_near/data/repositories/client_repository.dart';
import 'package:inquire_near/data/repositories/user_repository.dart';
import 'package:inquire_near/enums/role.dart';

part 'client_event.dart';
part 'client_state.dart';

class ClientBloc extends Bloc<ClientEvent, ClientState> {
  late StreamSubscription? _findAvailableInquirersSubscription;
  late ClientRepository clientRepository;
  late UserRepository userRepository;

  ClientBloc() : super(ClientInitial()) {
    clientRepository = ClientRepository();
    userRepository = UserRepository();
    _findAvailableInquirersSubscription = null;

    on<FindAvailableInquirers>(_onFindAvailableInquirers);

    on<EmitFindNewAvailableInquirers>(_onEmitFindNewAvailableInquirers);

    on<GetAvailableInquirers>(_onGetAvailableInquirers);

    on<EmitNoAvailableInquirers>(_onEmitNoAvailableInquirers);

    on<StopFindAvailableInquirer>(_onStopFindAvailableInquirer);

    on<HireInquirer>(_onHireInquirer);

    on<GetInquirerDetails>(_onGetInquirerDetails);
  }

  void _onFindAvailableInquirers(event, emit) {
    _findAvailableInquirersSubscription = FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: Role.Inquirer.toString())
        .where('isActive', isEqualTo: true)
        .snapshots()
        .listen((ev) async {
      if (ev.docs.isNotEmpty || ev.docChanges.isNotEmpty) {
        add(EmitFindNewAvailableInquirers());
        List<INUser> inquirers = [];
        for (var doc in ev.docs) {
          INUser inquirer = INUser.fromJson(doc.data());
          inquirer.setUID(doc.id);
          inquirers.add(inquirer);
        }
        add(GetAvailableInquirers(inquirers));
      } else if (ev.docs.isEmpty) {
        add(EmitNoAvailableInquirers());
      }
    });
  }

  void _onEmitFindNewAvailableInquirers(event, emit) {
    // Just emit an Empty() state to change the state for a moment
    // after finding new available inquirers.
    emit(Empty());
  }

  void _onGetAvailableInquirers(event, emit) {
    if (event.inquirers.isEmpty) {
      emit(NoAvailableInquirersFound());
    } else {
      emit(NewAvailableInquirersFound(event.inquirers));
    }
  }

  void _onEmitNoAvailableInquirers(event, emit) {
    emit(NoAvailableInquirersFound());
  }

  void _onStopFindAvailableInquirer(event, emit) {
    if (_findAvailableInquirersSubscription != null) {
      _findAvailableInquirersSubscription!.cancel();
    }
  }

  void _onHireInquirer(event, emit) async {
    bool isCreated =
        await clientRepository.createHiringRequest(event.hiringRequest);

    emit(CreateHiringRequestStatus(isCreated));
  }

  void _onGetInquirerDetails(event, emit) async {
    emit(Loading());

    Map<String, dynamic> data =
        await userRepository.getUserData(event.inquirerId);

    emit(RetrievedInquirerDetails(data));
  }
}
