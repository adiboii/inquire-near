// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';

// Project imports:
import 'package:inquire_near/themes/app_theme.dart' as theme;

class PaymentReceivedScreen extends StatelessWidget {
  const PaymentReceivedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Screen Dimensions
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: theme.kScreenPadding,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed(
                      '/review_client',
                    );
                  },
                  child: Image.asset(
                    'assets/images/illustrations/payment_received.png',
                    height: screenHeight * 0.25,
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                const AutoSizeText(
                  'Payment Received',
                  style: theme.subheadBold,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
