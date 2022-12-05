// Flutter imports:
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:inquire_near/enums/role.dart';

// Project imports:
import 'package:inquire_near/routes.dart';
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
import 'package:inquire_near/screens/client/release_payment/release_payment_screen.dart';
import 'package:inquire_near/screens/client/responses_screen.dart';
import 'package:inquire_near/screens/client/view_selected_inquiry_screen.dart';
import 'package:inquire_near/screens/client/waiting_for_hiring_request_status.dart';
import 'package:inquire_near/screens/common/about_inquirenear_screen.dart';
import 'package:inquire_near/screens/common/edit_profile_screen.dart';
import 'package:inquire_near/screens/common/error_screen.dart';
import 'package:inquire_near/screens/common/landing_screen.dart';
import 'package:inquire_near/screens/common/onboarding_screen.dart';
import 'package:inquire_near/screens/common/paypal_account_screen.dart';
import 'package:inquire_near/screens/common/profile_details/profile_details.dart';
import 'package:inquire_near/screens/common/profile_screen.dart';
import 'package:inquire_near/screens/common/report_screen.dart';
import 'package:inquire_near/screens/common/splash_screen.dart';
import 'package:inquire_near/screens/common/top_up.dart';
import 'package:inquire_near/screens/inquirer/answer_inquiry/inquirer_inquiry_list_screen.dart';
import 'package:inquire_near/screens/inquirer/answer_inquiry/inquirer_view_selected_inquiry_screen.dart';
import 'package:inquire_near/screens/inquirer/client_found/client_found_screen.dart';
import 'package:inquire_near/screens/inquirer/client_inquiry_list/client_inquiry_list.dart';
import 'package:inquire_near/screens/inquirer/inquirer_dashboard_screen.dart';
import 'package:inquire_near/screens/inquirer/payment_received_screen.dart';
import 'package:inquire_near/screens/inquirer/reminders_screen.dart';
import 'package:inquire_near/screens/common/review_screen.dart';
import 'package:inquire_near/screens/inquirer/waiting_for_client_to_pay.dart';
import 'package:inquire_near/wrapper.dart';
import 'screens/common/recent_transactions/view_transaction_inquiry_list_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      // Common Screens
      case wrapperRoute:
        return MaterialPageRoute(builder: (_) => const Wrapper());

      case splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case landingRoute:
        return MaterialPageRoute(builder: (_) => const LandingScreen());

      case loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case signUpRoute:
        return MaterialPageRoute(builder: (_) => SignUpScreen());

      case onboardingRoute:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());

      case topUpRoute:
        return MaterialPageRoute(builder: (_) => TopUpScreen());

      case reportRoute:
        return MaterialPageRoute(
            builder: (_) => const ReportScreen(reportByClient: false));

      case editProfileRoute:
        return MaterialPageRoute(builder: (_) => EditProfileScreen());

      case aboutInquireNearRoute:
        return MaterialPageRoute(
            builder: (_) => const AboutInquireNearScreen());

      case waitingForHiringRequestStatusRoute:
        return MaterialPageRoute(
            builder: (_) => const WaitingForHiringRequestStatusScreen());

      case transactionInquiryListRoute:
        if (args is bool) {
          return MaterialPageRoute(
              builder: (_) => TransactionInquiryListScreen(
                    isOngoing: args,
                  ));
        }
        break;

      case paypalAccountRoute:
        return MaterialPageRoute(builder: (_) => PaypalAccountScreen());

      // Client Screens
      case clientDashboardRoute:
        return MaterialPageRoute(builder: (_) => const ClientDashboardScreen());

      case profileRoute:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());

      case inquiryListRoute:
        return MaterialPageRoute(builder: (_) => const InquiryListScreen());

      case addInquiryRoute:
        return MaterialPageRoute(builder: (_) => const AddInquiryScreen());

      case findingInquirerRoute:
        return MaterialPageRoute(builder: (_) => const FindingInquirerScreen());

      case etaScreenRoute:
        return MaterialPageRoute(builder: (_) => const ETAScreen());

      case availableInquirersRoute:
        return MaterialPageRoute(
            builder: (_) => const AvailableInquirersScreen());

      case profileDetailsRoute:
        if (args is Map) {
          return MaterialPageRoute(
              builder: (_) => ProfileDetailsScreen(
                    userId: args["userId"],
                    isHiring: args["isHiring"],
                  ));
        }

        break;

      case viewSelectedInquiryRoute:
        return MaterialPageRoute(
            builder: (_) => const ViewSelectedInquiryScreen());

      case responsesRoute:
        return MaterialPageRoute(builder: (_) => const ResponsesScreen());

      case paymentSummaryRoute:
        return MaterialPageRoute(builder: (_) => const PaymentSummaryScreen());

      case releasePaymentRoute:
        return MaterialPageRoute(builder: (_) => const ReleasePaymentScreen());

      case paymentSuccessRoute:
        return MaterialPageRoute(builder: (_) => const PaymentSuccessScreen());

      case reportByClientRoute:
        return MaterialPageRoute(
            builder: (_) => const ReportScreen(reportByClient: true));

      case searchRoute:
        return MaterialPageRoute(builder: (_) => const SearchScreen());

      // Inquirer Screens
      case inquirerDashboardRoute:
        return MaterialPageRoute(
            builder: (_) => const InquirerDashboardScreen());

      case clientFoundRoute:
        return MaterialPageRoute(builder: (_) => const ClientFoundScreen());

      case remindersRoute:
        return MaterialPageRoute(builder: (_) => const RemindersScreen());

      case inquirerInquiryListRoute:
        return MaterialPageRoute(
            builder: (_) => const InquirerInquiryListScreen());

      case clientInquiryListRoute:
        return MaterialPageRoute(
            builder: (_) => const ClientInquiryListScreen());

      case inquirerViewSelectedInquiryRoute:
        return MaterialPageRoute(
            builder: (_) => InquirerViewSelectedInquiryScreen());

      case paymentReceivedRoute:
        return MaterialPageRoute(builder: (_) => const PaymentReceivedScreen());

      case reviewClientRoute:
        if (args is Map) {
          return MaterialPageRoute(
              builder: (_) => FeedbackScreen(
                    recepientId: args["recepient"],
                    feedbackerId: args['feedbacker'],
                  ));
        }
        break;

      case waitingForClientToPayRoute:
        return MaterialPageRoute(builder: (_) => const WaitingForClientToPay());
    }

    return MaterialPageRoute(builder: (_) => const ErrorScreen());
  }
}
