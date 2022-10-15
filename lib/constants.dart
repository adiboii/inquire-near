// App Routes

// Project imports:
import 'package:inquire_near/data/models/enums.dart';
import 'package:inquire_near/data/models/store_data.dart';

const String splash = "/splash";

// Map for Store List enum
//TODO: to implement

// Auth Error Codes
const String invalidEmail = 'invalid-email';
const String userDisabled = 'user-disabled';
const String operationNotAllowed = 'operation-not-allowed';
const String userNotFound = 'user-not-found';
const String wrongPassword = 'wrong-password';
const String emailAlreadyInUse = 'email-already-in-use';

final stores = [
  // Dining
  StoreData(name: 'Casa Verde', category: 'Dining'),
  StoreData(name: 'Seafood Island', category: 'Dining'),
  StoreData(name: 'Bigby\'s', category: 'Dining'),
  // Entertainment
  StoreData(name: 'SM Bowling Center', category: 'Entertainment'),
  StoreData(name: 'Ice Skating Rink', category: 'Entertainment'),
  StoreData(name: 'Color Museum', category: 'Entertainment'),
  // Cinema
  StoreData(name: 'Center Stage', category: 'Cinema'),
  StoreData(name: 'Director\'s Club', category: 'Cinema'),
  StoreData(name: 'SM Cinema', category: 'Cinema'),
  // Gadgets
  StoreData(name: 'DataBlitz', category: 'Gadgets'),
  StoreData(name: 'Octagon', category: 'Gadgets'),
  StoreData(name: 'iStore', category: 'Gadgets'),
  // Services
  StoreData(name: 'BDO', category: 'Services'),
  StoreData(name: 'Bruno\'s Barbers', category: 'Services'),
  StoreData(name: 'PLDT', category: 'Services'),
  // Shopping
  StoreData(name: 'SM Appliance Center', category: 'Shopping'),
  StoreData(name: 'Watsons', category: 'Shopping'),
  StoreData(name: 'H&M', category: 'Shopping'),
];
