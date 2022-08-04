import 'package:flutter/material.dart';
import 'package:inquire_near/screens/authenticate/login.dart';
import 'package:inquire_near/screens/authenticate/sign_up.dart';
import 'package:inquire_near/screens/homepage.dart';
import 'package:inquire_near/screens/onboarding.dart';
import 'package:inquire_near/screens/splash.dart';

class Routes {
  final Map<String, Function> _pages = {
    '/splash': (_) => Splash(),
    '/homepage': (_) => HomePage(),
    '/login': (_) => Login(),
    '/sign_up': (_) => SignUp(),
    '/onboarding': (_) => Onboarding(),
  };

  Map<String, Function> getPages() => _pages;
}
