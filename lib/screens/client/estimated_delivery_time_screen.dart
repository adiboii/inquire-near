// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:lottie/lottie.dart';

// Project imports:
import 'package:inquire_near/themes/app_theme.dart' as theme;

class ETAScreen extends StatefulWidget {
  const ETAScreen({Key? key}) : super(key: key);

  @override
  State<ETAScreen> createState() => _ETAScreenState();
}

class _ETAScreenState extends State<ETAScreen> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: theme.kScreenPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const Text(
                      "Estimated Delivery Time",
                      style: theme.headline,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    const Text(
                      "Sit back and relax while our\ninquirer handles things for you,",
                      style: theme.subhead,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    Lottie.asset("assets/images/lottie/eta.json",
                        height: screenHeight * 0.30),
                    SizedBox(height: screenHeight * 0.02),
                    const Text(
                      "25 min",
                      style: theme.headline,
                    ),
                  ],
                ),
              
              ],
            ),
          ),
        ),
      ),
    );
  }
}
