import 'dart:async';

import 'package:flutter/material.dart';
import 'package:inquire_near/components/buttons.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;
import 'package:lottie/lottie.dart';

class FindingInquirerScreen extends StatefulWidget {
  FindingInquirerScreen({Key? key}) : super(key: key);

  @override
  State<FindingInquirerScreen> createState() => _FindingInquirerScreenState();
}

class _FindingInquirerScreenState extends State<FindingInquirerScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, '/eta_screen');
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: theme.kScreenPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    "Finding an inquirer\nnear the area",
                    style: theme.title3,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24),
                  Lottie.asset("assets/images/lottie/finding_inquirer.json"),
                  SizedBox(height: 24),
                  Text(
                    "Hold on...",
                    style: theme.headline,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20),
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
