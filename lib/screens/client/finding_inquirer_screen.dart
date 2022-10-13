// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:lottie/lottie.dart';

// Project imports:
import 'package:inquire_near/themes/app_theme.dart' as theme;

class FindingInquirerScreen extends StatelessWidget {
  const FindingInquirerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: theme.kScreenPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const Text(
                "Finding an inquirer",
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
        ],
      ),
    );
  }
}
