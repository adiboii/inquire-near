// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:inquire_near/app_router.dart';
import 'package:inquire_near/bloc/bloc/Inquiry/inquiry_bloc.dart';
import 'package:inquire_near/bloc/bloc/auth/auth_bloc.dart';
import 'package:inquire_near/bloc/bloc/feedback/feedback_bloc.dart';
import 'package:inquire_near/data/repositories/auth_repository.dart';
import 'package:inquire_near/data/repositories/feedback_repository.dart';
import 'package:inquire_near/data/repositories/inquiry_repository.dart';

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
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(),
        ),
        RepositoryProvider(
          create: (context) => InquiryRepository(),
        ),
        RepositoryProvider<FeedbackRepository>(
          create: (context) => FeedbackRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              authRepository: RepositoryProvider.of<AuthRepository>(context),
            ),
          ),
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
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Inquire Near',
          initialRoute: '/landing',
          onGenerateRoute: appRouter.onGenerateRoute,
        ),
      ),
    );
  }
}
