// Package imports:
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
  final String? uid;
  final String? firstName;
  final String? lastName;
  Role role;
  bool? isActive;

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
