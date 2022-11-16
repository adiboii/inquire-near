// Dart imports:
import 'dart:developer';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';

// Project imports:
import 'package:inquire_near/collections.dart';
import 'package:inquire_near/data/models/hiring_request.dart';

class ClientRepository {
  late FirebaseFirestore db;

  ClientRepository() {
    db = FirebaseFirestore.instance;
  }

  Future<HiringRequest?> createHiringRequest(
      HiringRequest hiringRequest) async {
    try {
      DocumentReference hiringRequestRef = await db
          .collection(hiringRequestCollection)
          .add(hiringRequest.toJson());

      hiringRequest.id = hiringRequestRef.id;
      return hiringRequest;
    } catch (e) {
      log("createHiringRequestError > ${e.toString()}");
      return null;
    }
  }
}
