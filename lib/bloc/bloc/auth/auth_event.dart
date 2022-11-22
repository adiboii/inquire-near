part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class StorePaypalAddressRequested extends AuthEvent {
  final String email;
  StorePaypalAddressRequested(this.email);
}

// When the user signing in with email and password
//this event is called and the [AuthRepository] is called to sign in the user
class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  SignInRequested(this.email, this.password);
}

// When the user signing up with email and password
//this event is called and the [AuthRepository] is called to sign up the user
class SignUpRequested extends AuthEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  SignUpRequested(this.firstName, this.lastName, this.email, this.password);
}

// When the user edits the account with first name and last name
//this event is called and the [AuthRepository] is called to edit the user's account
class EditProfileRequested extends AuthEvent {
  final String firstName;
  final String lastName;

  EditProfileRequested(this.firstName, this.lastName);
}

// When the user signing in with google this event is
//called and the [AuthRepository] is called to sign in the user
class GoogleSignInRequested extends AuthEvent {}

// When the user signing out this event is called and the [AuthRepository] is called to sign out the user
class SignOutRequested extends AuthEvent {}

// Event to be called in Timer/polling
class EmitUnauthenticated extends AuthEvent {}

class SwitchRole extends AuthEvent {
  final Role currentRole;

  SwitchRole(this.currentRole);
}

class InitState extends AuthEvent {}

class DeactivateProfileRequested extends AuthEvent {}
