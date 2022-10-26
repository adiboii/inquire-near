// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';

class BaseModel {
  late Timestamp dateTimeCreated;

  BaseModel() {
    dateTimeCreated = Timestamp.now();
  }
}
