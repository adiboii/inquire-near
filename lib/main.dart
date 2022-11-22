// Dart imports:
import 'dart:developer';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:inquire_near/app_router.dart';
import 'package:inquire_near/bloc/bloc/Inquiry/inquiry_bloc.dart';
import 'package:inquire_near/bloc/bloc/auth/auth_bloc.dart';
import 'package:inquire_near/bloc/bloc/client/client_bloc.dart';
import 'package:inquire_near/bloc/bloc/feedback/feedback_bloc.dart';
import 'package:inquire_near/bloc/bloc/inquirer/inquirer_bloc.dart';
import 'package:inquire_near/bloc/bloc/payment/payment_bloc.dart';
import 'package:inquire_near/bloc/bloc/report/report_bloc.dart';
import 'package:inquire_near/bloc/bloc/transaction/transaction_bloc.dart';
import 'package:inquire_near/collections.dart';
import 'package:inquire_near/data/models/in_user.dart';
import 'package:inquire_near/data/repositories/auth_repository.dart';
import 'package:inquire_near/data/repositories/feedback_repository.dart';
import 'package:inquire_near/data/repositories/inquiry_repository.dart';
import 'package:inquire_near/data/repositories/paypal_repository.dart';
import 'package:inquire_near/data/repositories/report_repository.dart';
import 'package:inquire_near/data/repositories/transaction_repository.dart';
import 'package:inquire_near/data/repositories/user_repository.dart';
import 'package:inquire_near/routes.dart';

bool? showOnboarding = true;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  showOnboarding = preferences.getBool('showOnboarding');
  runApp(InquireNear(appRouter: AppRouter()));
}

class InquireNear extends StatefulWidget {
  InquireNear({super.key, required this.appRouter});
  final AppRouter appRouter;
  late bool? lastIsActiveState;

  @override
  State<InquireNear> createState() => _InquireNearState();
}

class _InquireNearState extends State<InquireNear> with WidgetsBindingObserver {
  @override
  void initState() {
    widget.lastIsActiveState = null;
    super.initState();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);

    bool isBackground = state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached;
    bool isResumed = state == AppLifecycleState.resumed;

    if (isBackground) {
      // Since this is the root parent class, we cannot access bloc
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        try {
          DocumentReference userReference = FirebaseFirestore.instance
              .collection(userCollection)
              .doc(user.uid);

          try {
            DocumentSnapshot userValue = await userReference.get();
            INUser u =
                INUser.fromJson(userValue.data() as Map<String, dynamic>);
            widget.lastIsActiveState = u.isActive;

            userReference.update({"isActive": false});
          } catch (_) {}
        } catch (e) {
          log(e.toString());
        }
      }
    } else if (isResumed) {
      // Restore last isActive state
      if (widget.lastIsActiveState != null) {
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          try {
            FirebaseFirestore.instance
                .collection(userCollection)
                .doc(user.uid)
                .update({"isActive": widget.lastIsActiveState});
          } catch (e) {
            log(e.toString());
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(),
        ),
        RepositoryProvider<InquiryRepository>(
          create: (context) => InquiryRepository(),
        ),
        RepositoryProvider<FeedbackRepository>(
          create: (context) => FeedbackRepository(),
        ),
        RepositoryProvider<ReportRepository>(
          create: (context) => ReportRepository(),
        ),
        RepositoryProvider<PayPalRepository>(
          create: (context) => PayPalRepository(),
        ),
        RepositoryProvider<TransactionRepository>(
          create: (context) => TransactionRepository(),
        ),
        RepositoryProvider<UserRepository>(
          create: (context) => UserRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
                authRepository: RepositoryProvider.of<AuthRepository>(context),
                userRepository: RepositoryProvider.of<UserRepository>(context)),
          ),
          BlocProvider<TransactionBloc>(
              create: (context) => TransactionBloc(
                    transactionRepository:
                        RepositoryProvider.of<TransactionRepository>(context),
                    userRepository:
                        RepositoryProvider.of<UserRepository>(context),
                  )),
          BlocProvider<InquiryBloc>(
            create: (context) => InquiryBloc(
              inquiryRepository:
                  RepositoryProvider.of<InquiryRepository>(context),
            ),
          ),
          BlocProvider<FeedbackBloc>(
            create: (context) => FeedbackBloc(
              feedbackRepository:
                  RepositoryProvider.of<FeedbackRepository>(context),
            ),
          ),
          BlocProvider<ReportBloc>(
            create: (context) => ReportBloc(
              reportRepository:
                  RepositoryProvider.of<ReportRepository>(context),
            ),
          ),
          BlocProvider<ClientBloc>(
            create: (context) => ClientBloc(),
          ),
          BlocProvider<InquirerBloc>(
            create: (context) => InquirerBloc(),
          ),
          BlocProvider<PaymentBloc>(
              create: (context) => PaymentBloc(
                  payPalRepository:
                      RepositoryProvider.of<PayPalRepository>(context)))
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Inquire Near',
          initialRoute: wrapperRoute,
          onGenerateRoute: widget.appRouter.onGenerateRoute,
        ),
      ),
    );
  }
}
