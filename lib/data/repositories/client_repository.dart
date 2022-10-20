// Dart imports:
import 'dart:developer';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';

// Project imports:
import 'package:inquire_near/data/models/hiring_request.dart';

class ClientRepository {
  late FirebaseFirestore db;

  ClientRepository() {
    db = FirebaseFirestore.instance;
  }

  Future<bool> createHiringRequest(HiringRequest hiringRequest) async {
    try {
      await db.collection('hiringRequests').add(hiringRequest.toJson());
      return true;
    } catch (e) {
      log("createHiringRequestError > ${e.toString()}");
      return false;
    }
  }
}
