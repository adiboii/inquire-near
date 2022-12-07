// Flutter imports:
import 'dart:developer';

import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inquire_near/bloc/bloc/Inquiry/inquiry_bloc.dart';
import 'package:inquire_near/bloc/bloc/auth/auth_bloc.dart';
import 'package:inquire_near/bloc/bloc/inquirer/inquirer_bloc.dart';
import 'package:inquire_near/enums/role.dart';
import 'package:inquire_near/screens/common/custom_alert_dialog.dart';
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

  void rebuildWidgetAndClearInquiry() {
    BlocProvider.of<TransactionBloc>(context).add(GetRecentTransaction(
        role: Role.inquirer,
        userId: BlocProvider.of<AuthBloc>(context).user!.uid!));
    BlocProvider.of<InquiryBloc>(context).add(ClearInquiry());
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    showAlertDialog(BuildContext context) async {
      // show the dialog
      bool result = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomAlertDialog(
            title: 'Cancel Hiring Request',
            content: 'Do you want to reject the request?',
            successText: 'Yes',
            onSuccess: () {
              BlocProvider.of<InquirerBloc>(context).add(RejectRequest());
              rebuildWidgetAndClearInquiry();
              Navigator.pop(context, true);
            },
            failText: 'Cancel',
            onFail: () {
              Navigator.pop(context, false);
            },
          );
        },
      );

      if (result) {
        // ignore: use_build_context_synchronously
        Navigator.pop(context, true);
      }
    }

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
      child: WillPopScope(
        onWillPop: () async {
          showAlertDialog(context);
          return true;
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
      ),
    );
  }
}
