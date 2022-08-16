import 'package:flutter/material.dart';
import 'package:inquire_near/components/buttons.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;
import 'package:lottie/lottie.dart';

class ETAScreen extends StatefulWidget {
  ETAScreen({Key? key}) : super(key: key);

  @override
  State<ETAScreen> createState() => _ETAScreenState();
}

class _ETAScreenState extends State<ETAScreen> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
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
                    "Estimated Delivery Time",
                    style: theme.headline,
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Sit back and relax while our\ninquirer handles things for you,",
                    style: theme.subhead,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  Lottie.asset("assets/images/lottie/eta.json",
                      height: height * 0.30),
                  SizedBox(height: 16),
                  Text(
                    "25 min",
                    style: theme.headline,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: ButtonOutline(
                  label: "View Inquiries",
                  style: theme.caption1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
