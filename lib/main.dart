// Flutter imports:
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inquire_near/data/repositories/auth_repository.dart';

// Project imports:
import 'package:inquire_near/screens/authenticate/login_screen.dart';
import 'package:inquire_near/screens/authenticate/sign_up_screen.dart';
import 'package:inquire_near/screens/client/add_inquiry_screen.dart';
import 'package:inquire_near/screens/client/available_inquirers_screen.dart';
import 'package:inquire_near/screens/client/client_dashboard_screen.dart';
import 'package:inquire_near/screens/client/estimated_delivery_time_screen.dart';
import 'package:inquire_near/screens/client/finding_inquirer_screen.dart';
import 'package:inquire_near/screens/client/inquiry_list_screen.dart';
import 'package:inquire_near/screens/client/payment_success_screen.dart';
import 'package:inquire_near/screens/client/payment_summary_screen.dart';
import 'package:inquire_near/screens/client/release_payment_screen.dart';
import 'package:inquire_near/screens/client/responses_screen.dart';
import 'package:inquire_near/screens/client/view_selected_inquiry_screen.dart';
import 'package:inquire_near/screens/common/landing_screen.dart';
import 'package:inquire_near/screens/common/onboarding_screen.dart';
import 'package:inquire_near/screens/common/profile_details.dart';
import 'package:inquire_near/screens/common/profile_screen.dart';
import 'package:inquire_near/screens/common/splash_screen.dart';
import 'package:inquire_near/screens/common/top_up.dart';
import 'package:inquire_near/screens/common/user_wallet.dart';
import 'package:inquire_near/screens/inquirer/client_found_screen.dart';
import 'package:inquire_near/screens/inquirer/inquirer_inquiry_list_screen.dart';
import 'package:inquire_near/screens/inquirer/inquirer_view_selected_inquiry_screen.dart';
import 'package:inquire_near/screens/inquirer/payment_received_screen.dart';
import 'package:inquire_near/screens/inquirer/reminders_screen.dart';
import 'package:inquire_near/screens/inquirer/review_client_screen.dart';

import 'bloc/bloc/auth_bloc.dart';

//import 'package:inquire_near/screens/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const InquireNear());
}

class InquireNear extends StatelessWidget {
  const InquireNear({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: BlocProvider(
        create: (context) => AuthBloc(
          authRepository: RepositoryProvider.of<AuthRepository>(context),
        ),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Inquire Near',
          initialRoute: '/splash',
          routes: {
            '/splash': (context) => const SplashScreen(),
            '/landing': (context) => const LandingScreen(),
            '/login': (context) => const LoginScreen(),
            '/sign_up': (context) => const SignUpScreen(),
            '/onboarding': (context) => const OnboardingScreen(),
            '/user_wallet': (context) => const UserWalletScreen(),
            '/top_up': (context) => TopUpScreen(),
            '/client_dashboard': (context) => const ClientDashboardScreen(),
            '/profile': (context) => const ProfileScreen(),
            '/inquiry_list': (context) => const InquiryListScreen(),
            '/add_inquiry': (context) => const AddInquiryScreen(),
            '/finding_inquirer': (context) => const FindingInquirerScreen(),
            '/eta_screen': (context) => const ETAScreen(),
            '/available_inquirers': (context) =>
                const AvailableInquirersScreen(),
            '/profile_details': (context) => const ProfileDetailsScreen(),
            '/view_selected_inquiry': (context) =>
                const ViewSelectedInquiryScreen(),
            '/responses': (context) => const ResponsesScreen(),
            '/payment_summary': (context) => const PaymentSummaryScreen(),
            '/release_payment': (context) => const ReleasePaymentScreen(),
            '/payment_success': (context) => const PaymentSuccessScreen(),
            // Inquirer Screens
            '/client_found': (context) => const ClientFoundScreen(),
            '/reminders': (context) => const RemindersScreen(),
            '/inquirer_inquiry_list': (context) =>
                const InquirerInquiryListScreen(),
            '/inquirer_view_selected_inquiry': (context) =>
                const InquirerViewSelectedInquiryScreen(),
            '/payment_received': (context) => const PaymentReceivedScreen(),
            '/review_client': (context) => const ReviewClientScreen(),
          },
        ),
      ),
    );
  }
}
