// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// Project imports:
import 'package:inquire_near/constants.dart' as constants;
import 'package:inquire_near/data/models/in_user.dart';

class SignUpWithEmailAndPasswordFailure implements Exception {
  const SignUpWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  factory SignUpWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case constants.invalidEmail:
        return const SignUpWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.',
        );
      case constants.emailAlreadyInUse:
        return const SignUpWithEmailAndPasswordFailure(
          'An account already exists for that email.',
        );
      case constants.operationNotAllowed:
        return const SignUpWithEmailAndPasswordFailure(
          'Operation is not allowed.  Please contact support.',
        );
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure(
          'Please enter a stronger password.',
        );
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }

  final String message;
}

class LogInWithEmailAndPasswordFailure implements Exception {
  const LogInWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  factory LogInWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case constants.invalidEmail:
        return const LogInWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.',
        );
      case constants.userDisabled:
        return const LogInWithEmailAndPasswordFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case constants.userNotFound:
        return const LogInWithEmailAndPasswordFailure(
          'Email is not found, please create an account.',
        );
      case constants.wrongPassword:
        return const LogInWithEmailAndPasswordFailure(
          'Incorrect password, please try again.',
        );
      default:
        return const LogInWithEmailAndPasswordFailure();
    }
  }

  /// The associated error message.
  final String message;
}

class LogInWithGoogleFailure implements Exception {
  const LogInWithGoogleFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory LogInWithGoogleFailure.fromCode(String code) {
    switch (code) {
      case 'account-exists-with-different-credential':
        return const LogInWithGoogleFailure(
          'Account exists with different credentials.',
        );
      case 'invalid-credential':
        return const LogInWithGoogleFailure(
          'The credential received is malformed or has expired.',
        );
      case 'operation-not-allowed':
        return const LogInWithGoogleFailure(
          'Operation is not allowed.  Please contact support.',
        );
      case constants.userDisabled:
        return const LogInWithGoogleFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case constants.userNotFound:
        return const LogInWithGoogleFailure(
          'Email is not found, please create an account.',
        );
      case constants.wrongPassword:
        return const LogInWithGoogleFailure(
          'Incorrect password, please try again.',
        );
      case 'invalid-verification-code':
        return const LogInWithGoogleFailure(
          'The credential verification code received is invalid.',
        );
      case 'invalid-verification-id':
        return const LogInWithGoogleFailure(
          'The credential verification ID received is invalid.',
        );
      case constants.emailAlreadyInUse:
        return const LogInWithGoogleFailure(
          'An account already exists for that email.',
        );
      default:
        return const LogInWithGoogleFailure();
    }
  }

  /// The associated error message.
  final String message;
}

class AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;

  Future<void> signUp(
      {required String firstName,
      required String lastName,
      required String email,
      required String password}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final userDocument = FirebaseFirestore.instance
          .collection('users')
          .doc(_firebaseAuth.currentUser!.uid);
      final user = INUser(
        uid: _firebaseAuth.currentUser!.uid,
        firstName: firstName,
        lastName: lastName,
      );
      await userDocument.set(user.toJSON());
    } on FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  Future<INUser> signIn(
      {required String email, required String password}) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      DocumentSnapshot<Map<String, dynamic>> user = await FirebaseFirestore
          .instance
          .collection("users")
          .doc(userCredential.user!.uid)
          .get();
      INUser userData = INUser.fromJson(user.data()!);

      return userData;
    } on FirebaseAuthException catch (e) {
      throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithEmailAndPasswordFailure();
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      Map<String, dynamic> idMap = parseJwt(googleAuth?.idToken);
      final userDocument = FirebaseFirestore.instance
          .collection('users')
          .doc(_firebaseAuth.currentUser!.uid);
      final user = INUser(
        uid: _firebaseAuth.currentUser!.uid,
        firstName: idMap['given_name'],
        lastName: idMap['family_name'],
        isActive: null,
      );
      await userDocument.set(user.toJSON());
    } on FirebaseAuthException catch (e) {
      throw LogInWithGoogleFailure(e.code);
    } catch (_) {
      throw const LogInWithGoogleFailure();
    }
  }

  static Map<String, dynamic> parseJwt(String? token) {
    final List<String> parts = token!.split('.');
    // retrieve token payload
    final String payload = parts[1];
    final String normalized = base64Url.normalize(payload);
    final String resp = utf8.decode(base64Url.decode(normalized));
    // convert to Map
    final payloadMap = json.decode(resp);
    return payloadMap;
  }
}
