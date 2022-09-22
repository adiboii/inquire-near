// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
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
          initialRoute: '/report',
          onGenerateRoute: appRouter.onGenerateRoute,
        ),
      ),
    );
  }
}
