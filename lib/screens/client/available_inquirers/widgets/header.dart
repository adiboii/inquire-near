
import 'package:flutter/material.dart';

import 'package:inquire_near/themes/app_theme.dart' as theme;

class Header extends StatelessWidget {
  const Header({
    Key? key,
    required this.screenHeight,
  }) : super(key: key);

  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Available Inquirers",
          style: theme.headline,
        ),
        SizedBox(height: screenHeight * 0.02),
        const Text(
          "Once you hire an inquirer, the order cannot be cancelled.\nMake sure to finalize your inquiries before hiring.",
          style: theme.caption1,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
