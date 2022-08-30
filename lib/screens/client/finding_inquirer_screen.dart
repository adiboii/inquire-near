// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:lottie/lottie.dart';

// Project imports:
import 'package:inquire_near/components/buttons.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class FindingInquirerScreen extends StatefulWidget {
  const FindingInquirerScreen({Key? key}) : super(key: key);

  @override
  State<FindingInquirerScreen> createState() => _FindingInquirerScreenState();
}

class _FindingInquirerScreenState extends State<FindingInquirerScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, '/eta_screen');
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: theme.kScreenPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const Text(
                    "Finding an inquirer\nnear the area",
                    style: theme.title3,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Lottie.asset("assets/images/lottie/finding_inquirer.json",
                      height: screenHeight * 0.4),
                  SizedBox(height: screenHeight * 0.01),
                  const Text(
                    "Hold on...",
                    style: theme.headline,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: ButtonOutline(
                  label: "Cancel",
                  style: theme.caption1,
                  color: theme.red,
                  textColor: theme.red,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
