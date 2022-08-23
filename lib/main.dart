import 'package:flutter/material.dart';
//import 'package:inquire_near/screens/routes.dart';
import 'package:inquire_near/screens/authenticate/login_screen.dart';
import 'package:inquire_near/screens/authenticate/sign_up_screen.dart';
import 'package:inquire_near/screens/client/add_inquiry_screen.dart';
import 'package:inquire_near/screens/client/available_inquirers_screen.dart';
import 'package:inquire_near/screens/client/client_dashboard_screen.dart';
import 'package:inquire_near/screens/client/estimated_delivery_time_screen.dart';
import 'package:inquire_near/screens/client/finding_inquirer_screen.dart';
import 'package:inquire_near/screens/client/inquiry_list_screen.dart';
import 'package:inquire_near/screens/common/landing_screen.dart';
import 'package:inquire_near/screens/common/onboarding_screen.dart';
import 'package:inquire_near/screens/common/profile_details.dart';
import 'package:inquire_near/screens/common/profile_screen.dart';
import 'package:inquire_near/screens/common/splash_screen.dart';
import 'package:inquire_near/screens/common/top_up.dart';
import 'package:inquire_near/screens/common/user_wallet.dart';

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
      initialRoute: '/profile_details',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/landing': (context) => LandingScreen(),
        '/login': (context) => LoginScreen(),
        '/sign_up': (context) => SignUpScreen(),
        '/onboarding': (context) => OnboardingScreen(),
        '/user_wallet': (context) => UserWalletScreen(),
        '/top_up': (context) => TopUpScreen(),
        '/client_dashboard': (context) => ClientDashboardScreen(),
        '/profile': (context) => ProfileScreen(),
        '/inquiry_list': (context) => InquiryListScreen(),
        '/add_inquiry': (context) => AddInquiryScreen(),
        '/finding_inquirer': (context) => FindingInquirerScreen(),
        '/eta_screen': (context) => ETAScreen(),
        '/available_inquirers': (context) => AvailableInquirersScreen(),
        '/profile_details': (context) => ProfileDetailsScreen(),
      },
    );
  }
}
