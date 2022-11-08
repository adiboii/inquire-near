// Dart imports:
import 'dart:async';
import 'dart:developer';
import 'dart:ffi';

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Project imports:
import 'package:inquire_near/data/models/in_user.dart';
import 'package:inquire_near/data/repositories/auth_repository.dart';
import 'package:inquire_near/data/repositories/user_repository.dart';
import 'package:inquire_near/enums/role.dart';

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
        log("User is null");
        user = null;
        add(EmitUnauthenticated());
      } else {
        try {
          user = await userRepository.getUser(u.uid);
          user!.setUID(u.uid);
        } catch (e) {
          add(SignOutRequested());
        }
      }
    });
    on<SignInRequested>(_onSignInRequested);
    on<SignUpRequested>(_onSignUpRequested);
    on<GoogleSignInRequested>(_onGoogleSignInRequested);
    on<SignOutRequested>(_onSignOutRequested);
    on<EmitUnauthenticated>(_onEmitUnauthenticated);
    on<SwitchRole>(_onSwitchRole);
  }

  _onSignInRequested(SignInRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      INUser u = await authRepository.signIn(
          email: event.email, password: event.password);
      user = u;
      log("User id: ${user!.uid}");
      emit(Authenticated());
    } on LogInWithEmailAndPasswordFailure catch (e) {
      emit(AuthError(e.message));
      emit(Unauthenticated());
    }
  }

  _onSignUpRequested(SignUpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
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
    emit(AuthLoading());
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
    emit(AuthLoading());
    user = null;
    await authRepository.signOut();
    emit(Unauthenticated());
  }

  _onEmitUnauthenticated(event, emit) {
    emit(Unauthenticated());
  }

  void _onSwitchRole(event, emit) async {
    Role currentRole = user!.role;
    Role roleToSwitch;

    if (currentRole == Role.Client) {
      roleToSwitch = Role.Inquirer;
      user!.role = Role.Inquirer;
    } else {
      roleToSwitch = Role.Client;
      user!.role = Role.Client;
    }

    //There is a bug where switching status changes the current role to client
    //TODO: fix bug
    userRepository.switchRole(id: user!.uid!, roleToSwitch: roleToSwitch);
  }
}
