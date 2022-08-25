import 'package:flutter/material.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;
import 'package:lottie/lottie.dart';

class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: theme.kScreenPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Lottie.asset("assets/images/lottie/payment_success.json",
                    height: screenHeight * 0.50),
              ),
              Text(
                "Payment Success!",
                style: theme.subhead_bold,
              )
            ],
          ),
        ),
      ),
    );
  }
}
