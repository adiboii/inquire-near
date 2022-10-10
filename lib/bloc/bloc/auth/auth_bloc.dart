// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:inquire_near/data/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(Unauthenticated()) {
    on<SignInRequested>(_onSignInRequested);
    on<SignUpRequested>(_onSignUpRequested);
    on<GoogleSignInRequested>(_onGoogleSignInRequested);
    on<SignOutRequested>(_onSignOutRequested);
  }

  _onSignInRequested(SignInRequested event, Emitter<AuthState> emit) async {
    emit(Loading());
    try {
      await authRepository.signIn(email: event.email, password: event.password);

      emit(Authenticated());
    } on LogInWithEmailAndPasswordFailure catch (e) {
      emit(AuthError(e.message));
      emit(Unauthenticated());
    }
  }

  _onSignUpRequested(SignUpRequested event, Emitter<AuthState> emit) async {
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
  }

  _onGoogleSignInRequested(
      GoogleSignInRequested event, Emitter<AuthState> emit) async {
    emit(Loading());
    try {
      await authRepository.signInWithGoogle();
      emit(Authenticated());
    } on LogInWithGoogleFailure catch (e) {
      emit(AuthError(e.message));
      emit(Unauthenticated());
    }
  }

  _onSignOutRequested(SignOutRequested event, Emitter<AuthState> emit) async {
    emit(Loading());
    await authRepository.signOut();
    emit(Unauthenticated());
  }
}
