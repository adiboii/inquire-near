// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

// Project imports:
import 'package:inquire_near/bloc/bloc/transaction/transaction_bloc.dart';
import 'package:inquire_near/routes.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class WaitingForClientToPay extends StatefulWidget {
  const WaitingForClientToPay({Key? key}) : super(key: key);

  @override
  State<WaitingForClientToPay> createState() => _WaitingForClientToPayState();
}

class _WaitingForClientToPayState extends State<WaitingForClientToPay> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TransactionBloc>(context).add(GetTransactionStatus());
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return BlocListener<TransactionBloc, TransactionState>(
      listener: (context, state) {
        if (state is RetrievedTransactionStatus) {
          Navigator.of(context).pushNamed(inquirerInquiryListRoute);
        }

        if (state is FailedTransactionStatus) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Payment from Client failed.')));
          Navigator.of(context).pushNamedAndRemoveUntil(
              inquirerDashboardRoute, (route) => false);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: theme.kScreenPadding,
              child: Column(
                children: [
                  const Text(
                    "Waiting for Client\nto Pay",
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
            ),
          ),
        ),
      ),
    );
  }
}
