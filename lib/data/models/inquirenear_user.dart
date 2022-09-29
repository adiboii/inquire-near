import 'package:equatable/equatable.dart';

class InquireNearUser extends Equatable {
  const InquireNearUser({
    this.uid,
    this.firstName,
    this.lastName,
  });
  final String? uid;
  final String? firstName;
  final String? lastName;

  @override
  List<Object?> get props => [uid, firstName, lastName];

  Map<String, dynamic> toJSON() => {
        'uid': uid,
        'firstName': firstName,
        'lastName': lastName,
      };
}
