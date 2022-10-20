// App Routes

// Project imports:
import 'package:inquire_near/data/models/enums.dart';

const String splash = "/splash";
// ignore: constant_identifier_names
const String PAYPAL_BASE_URL = "http://10.0.2.2:3000";

// Map for Store List enum
//TODO: to implement
Map<Store, Map<String, dynamic>> storeList = {};

// Auth Error Codes
const String invalidEmail = 'invalid-email';
const String userDisabled = 'user-disabled';
const String operationNotAllowed = 'operation-not-allowed';
const String userNotFound = 'user-not-found';
const String wrongPassword = 'wrong-password';
const String emailAlreadyInUse = 'email-already-in-use';
