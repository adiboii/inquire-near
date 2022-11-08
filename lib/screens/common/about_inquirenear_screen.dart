// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:inquire_near/bloc/bloc/auth/auth_bloc.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class AboutInquireNearScreen extends StatelessWidget {
  const AboutInquireNearScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        title: const Text(
          "About InquireNear",
          style: theme.title2,
        ),
        centerTitle: true,
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Unauthenticated) {
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/landing', (route) => false);
          }
        },
        child: Padding(
          padding: theme.kScreenPadding.copyWith(top: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [

              SizedBox(height: 25.0),
              Text(
                "InquireNear is an online platform providing real-time information to users who have inquiries about certain establishments and to provide job opportunities for other users.  The primary function of the application is to connect clients with inquirers. When a user has questions about specific places or physical establishments, they are called a client and they will hire an inquirer, a user within the vicinity will then travel to those locations and physically checks, asks, and/or verifies the answers to the client's questions, in exchange for a fee.",
                style: theme.caption1,
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
