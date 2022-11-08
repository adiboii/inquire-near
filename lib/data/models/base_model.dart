// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
abstract class BaseModel extends Equatable {
  late Timestamp dateTimeCreated;

  BaseModel() {
    dateTimeCreated = Timestamp.now();
  }
}
