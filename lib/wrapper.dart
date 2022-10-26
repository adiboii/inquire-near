import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inquire_near/bloc/bloc/auth/auth_bloc.dart';
import 'package:inquire_near/screens/client/client_dashboard/client_dashboard_screen.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
      if (state is Unauthenticated) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/landing', (route) => false);
      }
    }, builder: (context, state) {
      return const ClientDashboardScreen();
    });
  }
}
