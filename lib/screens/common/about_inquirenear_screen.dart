// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:inquire_near/bloc/bloc/auth/auth_bloc.dart';
import 'package:inquire_near/components/page_title.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class AboutInquireNearScreen extends StatelessWidget {
  const AboutInquireNearScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: theme.kScreenPadding.copyWith(top: 20),
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is Unauthenticated) {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/landing', (route) => false);
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PageTitle(
                  title: "About InquireNear",
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(height: screenHeight * 0.01),
                Image.asset(
                  'assets/images/illustrations/about_inquirenear.png',
                  height: screenHeight * 0.35,
                ),
                SizedBox(height: screenHeight * 0.02),
                const Text(
                  'InquireNear is an advocate for freedom of information',
                  style: theme.title3,
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  "InquireNear is an online platform providing an avenue for people to acquire real-time information regarding certain establishments and providing job opportunities for other users.",
                  style: theme.caption1.copyWith(
                    height: 2,
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  "InquireNear does this by connecting a client to an inquirer. When a user has questions, they are called a client. They will create their inquiries and then hire an inquirer, users who are tasked to visit those locations physically checks, asks, and/or verifies the answers to the client’s questions, in exchange for a fee.",
                  style: theme.caption1.copyWith(
                    height: 2,
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: screenHeight * 0.04),
                const Divider(
                  color: Colors.black,
                  thickness: 1.5,
                ),
                SizedBox(height: screenHeight * 0.02),
                const Text(
                  '"We believe in a world where information is truly at your fingertips."',
                  style: theme.bodyBold,
                ),
                SizedBox(height: screenHeight * 0.02),
                Row(
                  children: [
                    CircleAvatar(
                      radius: screenHeight * 0.04,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset(
                          'assets/images/illustrations/cymmer.png',
                        ),
                      ),
                    ),
                    SizedBox(width: screenHeight * 0.015),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Cymmer John Maranga',
                          style: theme.caption1Bold,
                        ),
                        Text(
                          'Founder',
                          style: theme.caption1,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
