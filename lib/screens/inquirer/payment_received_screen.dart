import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
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
                Image.asset(
                  'assets/images/illustrations/payment_received.png',
                  height: screenHeight * 0.25,
                ),
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                AutoSizeText(
                  'Payment Received',
                  style: theme.subhead_bold,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
