// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:inquire_near/constants.dart';
import 'package:inquire_near/screens/authenticate/login_screen.dart';
import 'package:inquire_near/screens/authenticate/sign_up_screen.dart';
import 'package:inquire_near/screens/client/Add_Inquiry_Screen/add_inquiry_screen.dart';
import 'package:inquire_near/screens/client/available_inquirers_screen.dart';
import 'package:inquire_near/screens/client/client_dashboard_screen.dart';
import 'package:inquire_near/screens/client/estimated_delivery_time_screen.dart';
import 'package:inquire_near/screens/client/finding_inquirer_screen.dart';
import 'package:inquire_near/screens/client/inquiry_list_screen.dart';
import 'package:inquire_near/screens/client/payment_success_screen.dart';
import 'package:inquire_near/screens/client/payment_summary/payment_summary_screen.dart';
import 'package:inquire_near/screens/client/release_payment_screen.dart';
import 'package:inquire_near/screens/client/responses_screen.dart';
import 'package:inquire_near/screens/client/view_selected_inquiry_screen.dart';
import 'package:inquire_near/screens/common/landing_screen.dart';
import 'package:inquire_near/screens/common/onboarding_screen.dart';
import 'package:inquire_near/screens/common/profile_details.dart';
import 'package:inquire_near/screens/common/profile_screen.dart';
import 'package:inquire_near/screens/common/report_screen.dart';
import 'package:inquire_near/screens/common/splash_screen.dart';
import 'package:inquire_near/screens/common/top_up.dart';
import 'package:inquire_near/screens/common/user_wallet.dart';
import 'package:inquire_near/screens/inquirer/client_found_screen.dart';
import 'package:inquire_near/screens/inquirer/inquirer_dashboard_screen.dart';
import 'package:inquire_near/screens/inquirer/inquirer_inquiry_list_screen.dart';
import 'package:inquire_near/screens/inquirer/inquirer_view_selected_inquiry_screen.dart';
import 'package:inquire_near/screens/inquirer/payment_received_screen.dart';
import 'package:inquire_near/screens/inquirer/reminders_screen.dart';
import 'package:inquire_near/screens/inquirer/review_client_screen.dart';

//TODO: implement
//Map Router

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {

      // Common Screens
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case '/landing':
        return MaterialPageRoute(builder: (_) => const LandingScreen());

      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case '/sign_up':
        return MaterialPageRoute(builder: (_) => SignUpScreen());

      case '/onboarding':
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());

      case '/user_wallet':
        return MaterialPageRoute(builder: (_) => const UserWalletScreen());

      case '/top_up':
        return MaterialPageRoute(builder: (_) => TopUpScreen());

      case '/report':
        return MaterialPageRoute(
            builder: (_) => const ReportScreen(reportByClient: false));

      // Client Screens

      case '/client_dashboard':
        return MaterialPageRoute(builder: (_) => const ClientDashboardScreen());

      case '/profile':
        return MaterialPageRoute(builder: (_) => const ProfileScreen());

      case '/inquiry_list':
        return MaterialPageRoute(builder: (_) => const InquiryListScreen());

      case '/add_inquiry':
        return MaterialPageRoute(builder: (_) => const AddInquiryScreen());

      case '/finding_inquirer':
        return MaterialPageRoute(builder: (_) => const FindingInquirerScreen());

      case '/eta_screen':
        return MaterialPageRoute(builder: (_) => const ETAScreen());

      case '/available_inquirers':
        return MaterialPageRoute(
            builder: (_) => const AvailableInquirersScreen());

      case '/profile_details':
        return MaterialPageRoute(builder: (_) => const ProfileDetailsScreen());

      case '/view_selected_inquiry':
        return MaterialPageRoute(
            builder: (_) => const ViewSelectedInquiryScreen());

      case '/responses':
        return MaterialPageRoute(builder: (_) => const ResponsesScreen());

      case '/payment_summary':
        return MaterialPageRoute(builder: (_) => const PaymentSummaryScreen());

      case '/release_payment':
        return MaterialPageRoute(builder: (_) => const ReleasePaymentScreen());

      case '/payment_success':
        return MaterialPageRoute(builder: (_) => const PaymentSuccessScreen());

      case '/report_by_client':
        return MaterialPageRoute(
            builder: (_) => const ReportScreen(reportByClient: true));

      // Inquirer Screens

      case '/inquirer_dashboard':
        return MaterialPageRoute(
            builder: (_) => const InquirerDashboardScreen());

      case '/client_found':
        return MaterialPageRoute(builder: (_) => const ClientFoundScreen());

      case '/reminders':
        return MaterialPageRoute(builder: (_) => const RemindersScreen());

      case '/inquirer_inquiry_list':
        return MaterialPageRoute(
            builder: (_) => const InquirerInquiryListScreen());

      case '/inquirer_view_selected_inquiry':
        return MaterialPageRoute(
            builder: (_) => const InquirerViewSelectedInquiryScreen());

      case '/payment_received':
        return MaterialPageRoute(builder: (_) => const PaymentReceivedScreen());

      case '/review_client':
        return MaterialPageRoute(builder: (_) => ClientFeedbackScreen());

      default:
        return null;
    }
  }
}
