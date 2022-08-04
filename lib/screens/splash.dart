import 'dart:async';
import 'package:flutter/material.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;
//TODO: apply shared preferences
//import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4), () {
      Navigator.pushReplacementNamed(context, '/onboarding');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image(
                image: AssetImage("assets/images/logo.png"),
                width: 200,
                height: 200,
              ),
            ),
            SizedBox(height: 100),
            Container(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "For everyone,\nby everyone",
                style: theme.header1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
