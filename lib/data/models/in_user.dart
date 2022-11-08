// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:inquire_near/enums/role.dart';

class INUser extends Equatable {
  INUser({
    this.uid,
    required this.firstName,
    required this.lastName,
    this.role = Role.Client,
    this.isActive,
  });
  String? uid;
  final String? firstName;
  final String? lastName;
  late Timestamp dateTimeCreated;
  Role role;
  bool? isActive;

  INUser.fromJson(Map<String, dynamic> json)
      : uid = json["uid"],
        firstName = json["firstName"],
        lastName = json["lastName"],
        role = getRoleFromString(json["role"]),
        isActive = json["isActive"];

  void setUID(String uid) {
    this.uid = uid;
  }

  @override
  List<Object?> get props => [uid, firstName, lastName];

  Map<String, dynamic> toJSON() {
    dateTimeCreated = Timestamp.now();
    return {
      'firstName': firstName,
      'lastName': lastName,
      'role': role.toValue(),
      'isActive': isActive,
      'dateTimeCreated': dateTimeCreated,
    };
  }
}
