import 'package:flutter/material.dart';
//import 'package:inquire_near/screens/routes.dart';
import 'package:inquire_near/screens/authenticate/login.dart';
import 'package:inquire_near/screens/authenticate/sign_up.dart';
import 'package:inquire_near/screens/homepage.dart';
import 'package:inquire_near/screens/onboarding.dart';
import 'package:inquire_near/screens/splash.dart';
import 'package:inquire_near/screens/top_up.dart';
import 'package:inquire_near/screens/user_wallet.dart';

void main() {
  runApp(const InquireNear());
}

class InquireNear extends StatelessWidget {
  const InquireNear({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Inquire Near',
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => Splash(),
        '/homepage': (context) => HomePage(),
        '/login': (context) => Login(),
        '/sign_up': (context) => SignUp(),
        '/onboarding': (context) => Onboarding(),
        '/user_wallet': (context) => UserWallet(),
        '/top_up': (context) => TopUp(),
      },
    );
  }
}
