// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inquire_near/bloc/bloc/transaction/transaction_bloc.dart';

// Project imports:
import 'package:inquire_near/routes.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class PaymentReceivedScreen extends StatelessWidget {
  const PaymentReceivedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Screen Dimensions
    double screenHeight = MediaQuery.of(context).size.height;

    var transactionBloc = BlocProvider.of<TransactionBloc>(context);
    String clientId = transactionBloc.client!.uid!;
    String inquirerId = transactionBloc.inquirer!.uid!;
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
                    Navigator.of(context)
                        .pushReplacementNamed(reviewClientRoute, arguments: {
                      'toFeedbackId': clientId,
                      'feedbacker': inquirerId
                    });
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
