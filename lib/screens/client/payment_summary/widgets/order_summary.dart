// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:inquire_near/themes/app_theme.dart' as theme;

class OrderSummary extends StatelessWidget {
  const OrderSummary({
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
            SizedBox(
              width: screenWidth * 0.02,
            ),
            const Text(
              'Order',
              style: theme.subheadBold,
            ),
          ],
        ),
        SizedBox(
          height: screenHeight * 0.015,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Inquiries',
              style: theme.caption1,
            ),
            Text(
              '4 x PHP 25.00',
              style: theme.caption1,
            ),
          ],
        ),
        SizedBox(
          height: screenHeight * 0.01,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Require Proof',
              style: theme.caption1,
            ),
            Text(
              '4 x PHP 5.00',
              style: theme.caption1,
            ),
          ],
        ),
        SizedBox(
          height: screenHeight * 0.01,
        ),
        const Divider(
          thickness: 0.9,
          color: Colors.black,
        ),
        SizedBox(
          height: screenHeight * 0.01,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Total Amount',
              style: theme.caption1,
            ),
            Text(
              'PHP 100.00',
              style: theme.headline,
            ),
          ],
        ),
      ],
    );
  }
}

