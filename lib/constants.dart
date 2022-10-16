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
  StoreData(
      name: 'Casa Verde',
      category: 'Dining',
      imageFileLocation: 'assets/images/logos/casa_verde.jpeg'),
  StoreData(
      name: 'Seafood Island',
      category: 'Dining',
      imageFileLocation: 'assets/images/logos/seafood_island.png'),
  StoreData(
      name: 'Bigby\'s',
      category: 'Dining',
      imageFileLocation: 'assets/images/logos/bigbys.jpeg'),
  // Entertainment
  StoreData(
      name: 'SM Bowling Center',
      category: 'Entertainment',
      imageFileLocation: 'assets/images/logos/sm_seaside.png'),
  StoreData(
      name: 'Ice Skating Rink',
      category: 'Entertainment',
      imageFileLocation: 'assets/images/logos/sm_seaside.png'),
  StoreData(
      name: 'Color Museum',
      category: 'Entertainment',
      imageFileLocation: 'assets/images/logos/color_museum.jpeg'),
  // Cinema
  StoreData(
      name: 'Center Stage',
      category: 'Cinema',
      imageFileLocation: 'assets/images/logos/sm_seaside.png'),
  StoreData(
      name: 'Director\'s Club',
      category: 'Cinema',
      imageFileLocation: 'assets/images/logos/sm_seaside.png'),
  StoreData(
      name: 'SM Cinema',
      category: 'Cinema',
      imageFileLocation: 'assets/images/logos/sm_seaside.png'),
  // Gadgets
  StoreData(
      name: 'DataBlitz',
      category: 'Gadgets',
      imageFileLocation: 'assets/images/logos/datablitz.jpeg'),
  StoreData(
      name: 'Octagon',
      category: 'Gadgets',
      imageFileLocation: 'assets/images/logos/octagon.png'),
  StoreData(
      name: 'iStore',
      category: 'Gadgets',
      imageFileLocation: 'assets/images/logos/apple_logo.png'),
  // Services
  StoreData(
      name: 'BDO',
      category: 'Services',
      imageFileLocation: 'assets/images/logos/bdo.png'),
  StoreData(
      name: 'Bruno\'s Barbers',
      category: 'Services',
      imageFileLocation: 'assets/images/logos/bruno_barbers.png'),
  StoreData(
      name: 'PLDT',
      category: 'Services',
      imageFileLocation: 'assets/images/logos/pldt.png'),
  // Shopping
  StoreData(
      name: 'SM Appliance Center',
      category: 'Shopping',
      imageFileLocation: 'assets/images/logos/sm_seaside.png'),
  StoreData(
      name: 'Watsons',
      category: 'Shopping',
      imageFileLocation: 'assets/images/logos/watsons.png'),
  StoreData(
      name: 'H&M',
      category: 'Shopping',
      imageFileLocation: 'assets/images/logos/hm.png'),
];

final categories = [
  'Dining',
  'Entertainment',
  'Cinema',
  'Gadgets',
  'Services',
  'Shopping'
];
