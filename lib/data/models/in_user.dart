// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';

// Project imports:
import 'package:inquire_near/data/models/base_model.dart';
import 'package:inquire_near/enums/role.dart';

// ignore: must_be_immutable
class INUser extends BaseModel {
  INUser(
      {this.uid,
      required this.firstName,
      required this.lastName,
      this.role = Role.client,
      this.isActive,
      this.email,
      this.password});
  String? uid;
  final String? firstName;
  final String? lastName;
  String? paypalAddress;
  Role role;
  bool? isActive;
  String? password;
  String? email;

  INUser.fromJson(Map<String, dynamic> json)
      : uid = json["uid"],
        firstName = json["firstName"],
        lastName = json["lastName"],
        role = getRoleFromString(json["role"]),
        isActive = json["isActive"];

  void setUID(String uid) {
    this.uid = uid;
  }

  void setPayPalAddress(String paypalAddress) {
    this.paypalAddress = paypalAddress;
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
      'paypalAddress': paypalAddress
    };
  }
}
