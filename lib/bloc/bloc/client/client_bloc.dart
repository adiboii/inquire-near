// Dart imports:
import 'dart:async';
import 'dart:developer';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:inquire_near/bloc/bloc/transaction/transaction_bloc.dart';
import 'package:inquire_near/collections.dart';
import 'package:inquire_near/data/models/hiring_request.dart';
import 'package:inquire_near/data/models/in_user.dart';
import 'package:inquire_near/data/repositories/client_repository.dart';
import 'package:inquire_near/data/repositories/user_repository.dart';
import 'package:inquire_near/enums/hiring_request_status.dart';
import 'package:inquire_near/enums/role.dart';

part 'client_event.dart';
part 'client_state.dart';

class ClientBloc extends Bloc<ClientEvent, ClientState> {
  late StreamSubscription? _findAvailableInquirersSubscription;
  late StreamSubscription _hiringRequestSubscription;
  late ClientRepository clientRepository;
  late UserRepository userRepository;
  HiringRequest? hiringRequest;

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

    on<ListenHiringRequest>(_onListenHiringRequest);

    on<UpdateHiringRequest>(_onUpdateHiringRequest);

    on<CancelHiringRequest>(_onCancelHiringRequest);
  }

  void _onCancelHiringRequest(event, emit) {
    clientRepository.cancelHiringRequest(hiringRequest!.id!);
  }

  void _onFindAvailableInquirers(event, emit) {
    _findAvailableInquirersSubscription = FirebaseFirestore.instance
        .collection(userCollection)
        .where('role', isEqualTo: Role.inquirer.toValue())
        .where('isActive', isEqualTo: true)
        .snapshots()
        .listen((ev) async {
      if (ev.docs.isNotEmpty || ev.docChanges.isNotEmpty) {
        add(EmitFindNewAvailableInquirers());
        List<INUser> inquirers = [];
        for (var doc in ev.docs) {
          // Check if inquirer has ongoing transaction
          try {
            bool hasOngoingTransaction =
                await TransactionBloc.hasOngoingTransaction(doc.id);
            if (hasOngoingTransaction) {
              // Remove inquirer if has current transaction
              inquirers.removeWhere((inquirer) => (inquirer.uid == doc.id));
            } else {
              INUser inquirer = INUser.fromJson(doc.data());
              inquirer.setUID(doc.id);
              inquirers.add(inquirer);
            }
          } catch (_) {}
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
    hiringRequest =
        await clientRepository.createHiringRequest(event.hiringRequest);

    emit(CreateHiringRequestStatus(hiringRequest != null));
  }

  void _onGetInquirerDetails(event, emit) async {
    emit(ClientLoading());

    Map<String, dynamic> data =
        await userRepository.getUserData(event.inquirerId);

    emit(RetrievedInquirerDetails(data));
  }

  void _onListenHiringRequest(event, emit) async {
    if (hiringRequest != null) {
      _hiringRequestSubscription = FirebaseFirestore.instance
          .collection(hiringRequestCollection)
          .doc(hiringRequest!.id)
          .snapshots()
          .listen((event) {
        if (event.exists) {
          HiringRequest hr = HiringRequest.fromJson(event.data()!);
          hr.id = hiringRequest!.id;

          if (hr.status != hiringRequest!.status &&
              hr.status != HiringRequestStatus.pending) {
            hiringRequest = hr;
            add(UpdateHiringRequest(hr.status));
          }
        }
      });
    }
  }

  void _onUpdateHiringRequest(event, emit) {
    if (event.hiringRequestStatus == HiringRequestStatus.accepted) {
      emit(AcceptedHiringRequest());
    } else if (event.hiringRequestStatus == HiringRequestStatus.cancelled) {
      add(FindAvailableInquirers());
      try {
        _hiringRequestSubscription.cancel();
      } catch (_) {}
    } else {
      emit(RejectedHiringRequest());
    }
    try {
      _hiringRequestSubscription.cancel();
      // ignore: empty_catches
    } catch (e) {}
  }

  Future<INUser?> getClient(String clientId) async {
    try {
      return await userRepository.getUser(clientId);
    } catch (e) {
      log("Get Client Error: $e");
    }

    return null;
  }
}
