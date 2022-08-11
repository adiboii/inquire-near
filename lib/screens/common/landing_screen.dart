import 'package:flutter/material.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;
import 'package:inquire_near/components/buttons.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
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
                image: AssetImage("assets/images/illustrations/landing.png"),
              ),
            ),
            SizedBox(height: 30),
            Align(
              alignment: Alignment.bottomLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome to",
                    style: theme.caption1,
                  ),
                  SizedBox(height: 5),
                  Text(
                    "InquireNear",
                    style: theme.title1,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Column(
              children: [
                ButtonFill(
                  label: "Sign In",
                  onTap: () {
                    Navigator.pushNamed(context, '/login');
                  },
                ),
                SizedBox(height: 10),
                ButtonOutline(
                  label: "Create Account",
                  onTap: () {
                    Navigator.pushNamed(context, '/sign_up');
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
