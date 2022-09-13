// Flutter imports:
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inquire_near/data/repositories/auth_repository.dart';
import 'package:inquire_near/presentation/router/app_router.dart';
import 'bloc/bloc/auth_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(InquireNear(appRouter: AppRouter()));
}

class InquireNear extends StatelessWidget {
  const InquireNear({super.key, required this.appRouter});
  final AppRouter appRouter;
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
            '/sign_up': (context) => SignUpScreen(),
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
