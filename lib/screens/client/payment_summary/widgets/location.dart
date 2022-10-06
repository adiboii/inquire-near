import 'package:flutter/material.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class Location extends StatelessWidget {
  const Location({
    Key? key,
    required this.screenWidth,
    required this.screenHeight,
  }) : super(key: key);

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: screenWidth * 0.02),
            const Text(
              'Location',
              style: theme.subheadBold,
            ),
          ],
        ),
        SizedBox(height: screenHeight * 0.015),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: screenWidth * 0.071,
            ),
            Image.asset(
              'assets/images/logos/BIR.png',
              width: screenWidth * 0.1,
            ),
            SizedBox(
              width: screenWidth * 0.03,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Bureau of Internal Revenue (BIR)',
                  style: theme.caption1,
                ),
                Text(
                  'Cebu South Branch',
                  style: theme.caption1,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
