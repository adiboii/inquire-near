import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:inquire_near/data/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(Unauthenticated()) {
    on<SignInRequested>((event, emit) async {
      emit(Loading());
      try {
        await authRepository.signIn(
            email: event.email, password: event.password);

        emit(Authenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(Unauthenticated());
      }
    });

    on<SignUpRequested>((event, emit) async {
      emit(Loading());
      try {
        await authRepository.signUp(
            firstName: event.firstName,
            lastName: event.lastName,
            email: event.email,
            password: event.password);
        emit(Authenticated());
      } on SignUpWithEmailAndPasswordFailure catch (e) {
        emit(AuthError(e.message));
        emit(Unauthenticated());
      }
    });

    on<GoogleSignInRequested>((event, emit) async {
      emit(Loading());
      try {
        await authRepository.signInWithGoogle();
        emit(Authenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(Unauthenticated());
      }
    });

    on<SignOutRequested>((event, emit) async {
      emit(Loading());
      await authRepository.signOut();
      emit(Unauthenticated());
    });
  }
}
