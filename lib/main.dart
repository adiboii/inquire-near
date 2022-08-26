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
import 'package:inquire_near/screens/client/responses_screen.dart';
import 'package:inquire_near/screens/client/view_selected_inquiry_screen.dart';
import 'package:inquire_near/screens/client/payment_success_screen.dart';
import 'package:inquire_near/screens/client/payment_summary_screen.dart';
import 'package:inquire_near/screens/client/release_payment_screen.dart';
import 'package:inquire_near/screens/common/landing_screen.dart';
import 'package:inquire_near/screens/common/onboarding_screen.dart';
import 'package:inquire_near/screens/common/profile_details.dart';
import 'package:inquire_near/screens/common/profile_screen.dart';
import 'package:inquire_near/screens/common/splash_screen.dart';
import 'package:inquire_near/screens/common/top_up.dart';
import 'package:inquire_near/screens/common/user_wallet.dart';
import 'package:inquire_near/screens/inquirer/client_found_screen.dart';
import 'package:inquire_near/screens/inquirer/inquirer_inquiry_list_screen.dart';
import 'package:inquire_near/screens/inquirer/payment_received_screen.dart';
import 'package:inquire_near/screens/inquirer/reminders_screen.dart';
import 'package:inquire_near/screens/inquirer/review_client_screen.dart';
import 'package:inquire_near/screens/inquirer/inquirer_view_selected_inquiry_screen.dart';

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
      initialRoute: '/client_found',
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
        '/view_selected_inquiry': (context) => ViewSelectedInquiryScreen(),
        '/responses': (context) => ResponsesScreen(),
        '/payment_summary': (context) => PaymentSummaryScreen(),
        '/release_payment': (context) => ReleasePaymentScreen(),
        '/payment_success': (context) => PaymentSuccessScreen(),
        // Inquirer Screens
        '/client_found': (context) => ClientFoundScreen(),
        '/reminders': (context) => RemindersScreen(),
        '/inquirer_inquiry_list': (context) => InquirerInquiryListScreen(),
        '/inquirer_view_selected_inquiry': (context) =>
            InquirerViewSelectedInquiryScreen(),
        '/payment_received': (context) => PaymentReceivedScreen(),
        '/review_client': (context) => ReviewClientScreen(),
      },
    );
  }
}
