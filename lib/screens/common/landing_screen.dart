import 'package:flutter/material.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;
import 'package:inquire_near/components/buttons.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: theme.kScreenPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        "Find the things\nyou need",
                        textAlign: TextAlign.right,
                        style: theme.headline,
                      ),
                    ),
                    Center(
                      child: Image(
                        width: 250,
                        image: AssetImage(
                            "assets/images/illustrations/landing.png"),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.05),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome to",
                            style: theme.body,
                          ),
                          Text(
                            "InquireNear",
                            style: theme.largeTitle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              Column(
                children: [
                  ButtonFill(
                    label: "Create an account",
                    style: theme.headline,
                    onTap: () {
                      Navigator.pushNamed(context, '/sign_up');
                    },
                  ),
                  SizedBox(height: screenHeight * 0.015),
                  ButtonOutline(
                    label: "Sign in",
                    onTap: () {
                      Navigator.pushNamed(context, '/login');
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
