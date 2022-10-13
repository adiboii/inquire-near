// Package imports:
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:inquire_near/enums/role.dart';

class INUser extends Equatable {
  INUser({
    this.uid,
    required this.firstName,
    required this.lastName,
    this.role = Role.Client,
    this.isActive,
  });
  late String? uid;
  final String? firstName;
  final String? lastName;
  Role role;
  bool? isActive;

  INUser.fromJson(Map<String, dynamic> json)
      : firstName = json["firstName"],
        lastName = json["lastName"],
        role = getRoleFromString(json["role"]),
        isActive = json["isActive"];

  void setUID(String uid) {
    this.uid = uid;
  }

  @override
  List<Object?> get props => [uid, firstName, lastName];

  Map<String, dynamic> toJSON() => {
        'uid': uid,
        'firstName': firstName,
        'lastName': lastName,
        'role': role.toString(),
        'isActive': isActive,
      };
}
