// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inquire_near/screens/common/custom_alert_dialog.dart';
import 'package:jumping_dot/jumping_dot.dart';

// Project imports:
import 'package:inquire_near/bloc/bloc/client/client_bloc.dart';
import 'package:inquire_near/routes.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class WaitingForHiringRequestStatusScreen extends StatefulWidget {
  const WaitingForHiringRequestStatusScreen({Key? key}) : super(key: key);

  @override
  State<WaitingForHiringRequestStatusScreen> createState() =>
      _WaitingForHiringRequestStatus();
}

class _WaitingForHiringRequestStatus
    extends State<WaitingForHiringRequestStatusScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ClientBloc>(context).add(ListenHiringRequest());
  }

  showAlertDialog(BuildContext context) async {
    // show the dialog
    bool result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          title: 'Cancel Hiring Request',
          content: 'Do you want to cancel this hiring request?',
          successText: 'Yes',
          onSuccess: () {
            BlocProvider.of<ClientBloc>(context).add(CancelHiringRequest());
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

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return BlocListener<ClientBloc, ClientState>(
      listener: (context, state) {
        if (state is AcceptedHiringRequest) {
          Navigator.of(context).pushNamed(paymentSummaryRoute);
        }

        if (state is RejectedHiringRequest) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Inquirer rejected your request. Try again.")));
          BlocProvider.of<ClientBloc>(context).add(FindAvailableInquirers());
          Navigator.of(context).pop();
        }
      },
      child: WillPopScope(
        onWillPop: () async {
          showAlertDialog(context);
          return true;
        },
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: theme.kScreenPadding,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          const Text(
                            "Waiting for Inquirer to Accept",
                            style: theme.headline,
                          ),
                          SizedBox(height: screenHeight * 0.025),
                          const JumpingDots(
                            color: theme.primary,
                            radius: 20,
                            numberOfDots: 5,
                            innerPadding: 8,
                            animationDuration: Duration(milliseconds: 300),
                          ),
                        ],
                      ),
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
