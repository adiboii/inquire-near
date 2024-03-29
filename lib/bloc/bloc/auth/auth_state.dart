part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {}

// When the user presses the signin or signup button the
//state is changed to loading first and then to Authenticated.
class AuthLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

// When the user is authenticated
//the state is changed to Authenticated.
class Authenticated extends AuthState {
  final bool isFromSignup;

  Authenticated({required this.isFromSignup});

  @override
  List<Object?> get props => [];
}

// This is the initial state of the bloc.
// When the user is not authenticated the state is
//changed to Unauthenticated.
class Unauthenticated extends AuthState {
  @override
  List<Object?> get props => [];
}

// If any error occurs the state
//is changed to AuthError.
class AuthError extends AuthState {
  final String error;
  AuthError(this.error);
  @override
  List<Object?> get props => [];
}

class AuthDeleted extends AuthState {
  @override
  List<Object?> get props => [];
}

class EditedProfile extends AuthState {
  @override
  List<Object?> get props => [];
}

class PaypalAddressStored extends AuthState {
  @override
  List<Object?> get props => [];
}
