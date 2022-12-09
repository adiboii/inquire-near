// Dart imports:
import 'dart:async';
import 'dart:developer';

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
    Timer.periodic(const Duration(seconds: 1), (_) async {
      if (state is! AuthLoading || state is! AuthError) {
        User? u = FirebaseAuth.instance.currentUser;
        if (u == null) {
          user = null;
          add(EmitUnauthenticated());
        } else {
          try {
            user = await userRepository.getUser(u.uid);
          } catch (e) {
            log("Timer Auth Bloc Get User Error > $e");
            // add(SignOutRequested());
          }
        }
      }
    });
    on<SignInRequested>(_onSignInRequested);
    on<SignUpRequested>(_onSignUpRequested);
    on<GoogleSignInRequested>(_onGoogleSignInRequested);
    on<SignOutRequested>(_onSignOutRequested);
    on<EmitUnauthenticated>(_onEmitUnauthenticated);
    on<SwitchRole>(_onSwitchRole);
    on<InitState>(_onInitState);
    on<EditProfileRequested>(_onEditProfileRequested);
    on<DeleteProfileRequested>(_onDeleteProfileRequested);
    on<StorePaypalAddressRequested>(_onStorePaypalAddressRequested);
  }

  _onStorePaypalAddressRequested(
      StorePaypalAddressRequested event, Emitter<AuthState> emit) async {
    try {
      await authRepository.storePaypalAddress(paypalAddress: event.email);
      emit(PaypalAddressStored());
    } catch (_) {}
  }

  _onSignInRequested(SignInRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      INUser u = await authRepository.signIn(
          email: event.email, password: event.password);
      user = u;
      emit(Authenticated(isFromSignup: user!.paypalAddress == null));
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
      emit(Authenticated(isFromSignup: true));
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

      emit(Authenticated(isFromSignup: u.paypalAddress == null));
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
    Role currentRole = event.currentRole;
    Role roleToSwitch;

    if (currentRole == Role.client) {
      roleToSwitch = Role.inquirer;
      user!.role = Role.inquirer;
    } else {
      roleToSwitch = Role.client;
      user!.role = Role.client;
    }

    userRepository.switchRole(id: user!.uid!, roleToSwitch: roleToSwitch);
  }

  _onEditProfileRequested(
      EditProfileRequested event, Emitter<AuthState> emit) async {
    try {
      INUser u = await authRepository.editProfile(
        firstName: event.firstName,
        lastName: event.lastName,
      );
      user = u;
      emit(EditedProfile());
    } catch (e) {
      rethrow;
    }
  }

  _onDeleteProfileRequested(
      DeleteProfileRequested event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading()); //stop timer
      await authRepository.deleteAccount(
          event.email, event.password); // delete account
      emit(AuthDeleted()); // sign out
      add(SignOutRequested());
    } on ReauthenticateUserFailure catch (e) {
      if (e.message == 'too-many-requests') {
        emit(AuthError("Too many failed attemps. Please sign in again."));
        add(SignOutRequested());
      } else {
        emit(AuthError(e.message));
        emit(Authenticated(isFromSignup: false));
      }
    } catch (e) {
      log("Auth Bloc > Delete Profile: $e");
    }
  }

  _onInitState(event, emit) async {
    emit(AuthLoading());
    User? u = FirebaseAuth.instance.currentUser;

    if (u == null) {
      emit(Unauthenticated());
    } else {
      try {
        user = await userRepository.getUser(u.uid);
        emit(Authenticated(isFromSignup: false));
      } catch (e) {
        add(SignOutRequested());
      }
    }
  }
}
