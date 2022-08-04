import 'package:flutter/material.dart';
import 'package:inquire_near/screens/authenticate/login_screen.dart';
import 'package:inquire_near/screens/authenticate/sign_up_screen.dart';
import 'package:inquire_near/screens/common/landing_screen.dart';
import 'package:inquire_near/screens/common/onboarding_screen.dart';
import 'package:inquire_near/screens/common/splash_screen.dart';

class Routes {
  final Map<String, Function> _pages = {
    '/splash': (_) => SplashScreen(),
    '/homepage': (_) => LandingScreen(),
    '/login': (_) => LoginScreen(),
    '/sign_up': (_) => SignUpScreen(),
    '/onboarding': (_) => OnboardingScreen(),
  };

  Map<String, Function> getPages() => _pages;
}
