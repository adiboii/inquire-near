// Flutter imports:
import 'dart:async';

import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inquire_near/enums/role.dart';
import 'package:inquire_near/screens/common/paypal_account_screen.dart';
import 'package:inquire_near/screens/inquirer/inquirer_dashboard_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:inquire_near/bloc/bloc/auth/auth_bloc.dart';
import 'package:inquire_near/data/models/in_user.dart';
import 'package:inquire_near/routes.dart';
import 'package:inquire_near/screens/client/client_dashboard/client_dashboard_screen.dart';
import 'package:inquire_near/screens/common/splash_screen.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool? showOnboarding;
  SharedPreferences? preferences;
  INUser? user;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 0), () async {
      preferences = await SharedPreferences.getInstance();
      if (preferences != null) {
        showOnboarding = preferences!.getBool('showOnboarding');
      }
    });

    BlocProvider.of<AuthBloc>(context).add(InitState());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
      if (state is Unauthenticated) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            showOnboarding == null || !showOnboarding!
                ? landingRoute
                : onboardingRoute,
            (route) => false);
      }
    }, builder: (context, state) {
      if (state is Authenticated && !state.isFromSignup) {
        INUser? user = BlocProvider.of<AuthBloc>(context).user;

        if (user != null &&
            (user.paypalAddress == null || user.paypalAddress == "")) {
          // log("HERE!!");
          return PaypalAccountScreen();
          // Navigator.of(context).pushNamed(paypalAccountRoute);
        }

        if (user!.role == Role.inquirer) {
          return const InquirerDashboardScreen();
        }
        return const ClientDashboardScreen();
      }

      return const SplashScreen();
    });
  }
}
