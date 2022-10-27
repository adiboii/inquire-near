// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:inquire_near/constants.dart';
import 'package:inquire_near/screens/authenticate/login_screen.dart';
import 'package:inquire_near/screens/authenticate/sign_up_screen.dart';
import 'package:inquire_near/screens/client/Add_Inquiry_Screen/add_inquiry_screen.dart';
import 'package:inquire_near/screens/client/Inquiry_List_Screen/inquiry_list_screen.dart';
import 'package:inquire_near/screens/client/available_inquirers/available_inquirers_screen.dart';
import 'package:inquire_near/screens/client/client_dashboard/client_dashboard_screen.dart';
import 'package:inquire_near/screens/client/client_dashboard/search_screen.dart';
import 'package:inquire_near/screens/client/estimated_delivery_time_screen.dart';
import 'package:inquire_near/screens/client/finding_inquirer_screen.dart';
import 'package:inquire_near/screens/client/payment_success_screen.dart';
import 'package:inquire_near/screens/client/payment_summary/payment_summary_screen.dart';
import 'package:inquire_near/screens/client/release_payment_screen.dart';
import 'package:inquire_near/screens/client/responses_screen.dart';
import 'package:inquire_near/screens/client/view_selected_inquiry_screen.dart';
import 'package:inquire_near/screens/common/error_screen.dart';
import 'package:inquire_near/screens/common/landing_screen.dart';
import 'package:inquire_near/screens/common/onboarding_screen.dart';
import 'package:inquire_near/screens/common/profile_details/profile_details.dart';
import 'package:inquire_near/screens/common/profile_screen.dart';
import 'package:inquire_near/screens/common/report_screen.dart';
import 'package:inquire_near/screens/common/splash_screen.dart';
import 'package:inquire_near/screens/common/top_up.dart';
import 'package:inquire_near/screens/common/user_wallet.dart';
import 'package:inquire_near/screens/inquirer/client_found/client_found_screen.dart';
import 'package:inquire_near/screens/inquirer/client_inquiry_list/client_inquiry_list.dart';
import 'package:inquire_near/screens/inquirer/inquirer_dashboard_screen.dart';
import 'package:inquire_near/screens/inquirer/answer_inquiry/inquirer_inquiry_list_screen.dart';
import 'package:inquire_near/screens/inquirer/answer_inquiry/inquirer_view_selected_inquiry_screen.dart';
import 'package:inquire_near/screens/inquirer/payment_received_screen.dart';
import 'package:inquire_near/screens/inquirer/reminders_screen.dart';
import 'package:inquire_near/screens/inquirer/review_client_screen.dart';
import 'package:inquire_near/screens/inquirer/waiting_for_client_to_pay.dart';
import 'package:inquire_near/wrapper.dart';

//TODO: implement
//Map Router

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {

      // Common Screens
      case '/wrapper':
        return MaterialPageRoute(builder: (_) => const Wrapper());
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
        if (args is Map) {
          return MaterialPageRoute(
              builder: (_) => ProfileDetailsScreen(
                    userId: args["userId"],
                    isHiring: args["isHiring"],
                  ));
        }

        break;

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

      case '/search':
        return MaterialPageRoute(builder: (_) => const SearchScreen());

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

      case '/client_inquiry_list':
        return MaterialPageRoute(
            builder: (_) => const ClientInquiryListScreen());

      case '/inquirer_view_selected_inquiry':
        return MaterialPageRoute(
            builder: (_) => InquirerViewSelectedInquiryScreen());

      case '/payment_received':
        return MaterialPageRoute(builder: (_) => const PaymentReceivedScreen());

      case '/review_client':
        return MaterialPageRoute(builder: (_) => const ClientFeedbackScreen());

      case '/waiting_for_client_to_pay':
        return MaterialPageRoute(builder: (_) => const WaitingForClientToPay());
    }

    return MaterialPageRoute(builder: (_) => const ErrorScreen());
  }
}
