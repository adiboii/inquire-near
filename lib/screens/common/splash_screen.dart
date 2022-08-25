import 'dart:async';
import 'package:flutter/material.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;
//TODO: apply shared preferences
//import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashState();
}

class _SplashState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4), () {
      Navigator.pushReplacementNamed(context, '/onboarding');
    });
  }

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
              Center(
                child: Image(
                  image: AssetImage("assets/images/logos/logo.png"),
                  width: 200,
                  height: 200,
                ),
              ),
              SizedBox(height: screenHeight * 0.1),
              Container(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "For everyone,\nby everyone",
                  style: theme.title1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
