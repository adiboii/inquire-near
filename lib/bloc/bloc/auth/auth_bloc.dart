// Flutter imports:
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:inquire_near/data/models/in_user.dart';

// Project imports:
import 'package:inquire_near/data/repositories/auth_repository.dart';
import 'package:inquire_near/data/repositories/user_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  final UserRepository userRepository;
  INUser? user;

  AuthBloc({required this.authRepository, required this.userRepository})
      : super(Unauthenticated()) {
    Timer.periodic(const Duration(seconds: 5), (_) async {
      User? u = FirebaseAuth.instance.currentUser;

      if (u == null) {
        user = null;
        add(EmitUnauthenticated());
      } else {
        user = await userRepository.getUser(u.uid);
      }
    });
    on<SignInRequested>(_onSignInRequested);
    on<SignUpRequested>(_onSignUpRequested);
    on<GoogleSignInRequested>(_onGoogleSignInRequested);
    on<SignOutRequested>(_onSignOutRequested);
    on<EmitUnauthenticated>(_onEmitUnauthenticated);
  }

  _onSignInRequested(SignInRequested event, Emitter<AuthState> emit) async {
    emit(Loading());
    try {
      INUser u = await authRepository.signIn(
          email: event.email, password: event.password);
      user = u;
      emit(Authenticated());
    } on LogInWithEmailAndPasswordFailure catch (e) {
      emit(AuthError(e.message));
      emit(Unauthenticated());
    }
  }

  _onSignUpRequested(SignUpRequested event, Emitter<AuthState> emit) async {
    emit(Loading());
    try {
      INUser u = await authRepository.signUp(
          firstName: event.firstName,
          lastName: event.lastName,
          email: event.email,
          password: event.password);

      user = u;
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
      INUser u = await authRepository.signInWithGoogle();
      user = u;
      emit(Authenticated());
    } on LogInWithGoogleFailure catch (e) {
      emit(AuthError(e.message));
      emit(Unauthenticated());
    }
  }

  _onSignOutRequested(SignOutRequested event, Emitter<AuthState> emit) async {
    emit(Loading());
    user = null;
    await authRepository.signOut();
    emit(Unauthenticated());
  }

  _onEmitUnauthenticated(event, emit) {
    emit(Unauthenticated());
  }
}
