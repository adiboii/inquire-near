// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:inquire_near/bloc/bloc/auth/auth_bloc.dart';
import 'package:inquire_near/bloc/bloc/client/client_bloc.dart';
import 'package:inquire_near/bloc/bloc/transaction/transaction_bloc.dart';
import 'package:inquire_near/data/models/hiring_request.dart';
import 'package:inquire_near/enums/hiring_request_status.dart';
import 'package:inquire_near/routes.dart';
import 'package:inquire_near/screens/client/available_inquirers/widgets/available_inquirer.dart';
import 'package:inquire_near/screens/client/available_inquirers/widgets/cancel_button.dart';
import 'package:inquire_near/screens/client/available_inquirers/widgets/header.dart';
import 'package:inquire_near/screens/client/finding_inquirer_screen.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class AvailableInquirersScreen extends StatefulWidget {
  const AvailableInquirersScreen({Key? key}) : super(key: key);

  @override
  State<AvailableInquirersScreen> createState() =>
      _AvailableInquirersScreenState();
}

class _AvailableInquirersScreenState extends State<AvailableInquirersScreen> {
  bool isETA = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ClientBloc>(context).add(FindAvailableInquirers());
  }

  showAlertErrorDialog(BuildContext context) async {
    // set up the button
    Widget tryAgain = TextButton(
      child: const Text("Try again"),
      onPressed: () {
        Navigator.pop(context, true);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Error"),
      content: const Text("Something went wrong. Try again"),
      actions: [tryAgain],
    );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      // show the dialog
      bool result = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );

      if (result && mounted) {
        BlocProvider.of<ClientBloc>(context).add(FindAvailableInquirers());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
    TransactionBloc transactionBloc = BlocProvider.of<TransactionBloc>(context);
    return Scaffold(
      body: Padding(
        padding: theme.kScreenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Header(screenHeight: screenHeight),
            SizedBox(height: screenHeight * 0.02),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: BlocBuilder<ClientBloc, ClientState>(
                  builder: (_, state) {
                    if (state is CreateHiringRequestStatus) {
                      if (state.status) {
                        Future.delayed(Duration.zero, () {
                          Navigator.of(context)
                              .pushNamed(waitingForHiringRequestStatusRoute);
                        });
                      } else {
                        showAlertErrorDialog(context);
                      }
                    }

                    if (state is NoAvailableInquirersFound) {
                      return const FindingInquirerScreen();
                    }

                    if (state is NewAvailableInquirersFound) {
                      return ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.inquirers.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (_, index) {
                          return GestureDetector(
                            onTap: () async {
                              final result = await Navigator.pushNamed(
                                  context, profileDetailsRoute, arguments: {
                                "userId": state.inquirers[index].uid,
                                "isHiring": true
                              });

                              // Check first if inquirer already has transaction
                              bool hasOngoingTransaction =
                                  await TransactionBloc.hasOngoingTransaction(
                                      state.inquirers[index].uid.toString());

                              if (mounted && hasOngoingTransaction) {
                                BlocProvider.of<ClientBloc>(context)
                                    .add(FindAvailableInquirers());
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Inquirer already has ongoing transaction. Try again.")));
                              } else if (result is bool && result) {
                                HiringRequest hiringRequest = HiringRequest(
                                    transactionId:
                                        transactionBloc.transaction!.id!,
                                    clientId: authBloc.user!.uid!,
                                    inquirerId:
                                        state.inquirers[index].uid.toString(),
                                    status: HiringRequestStatus.pending);

                                if (!mounted) return;
                                BlocProvider.of<ClientBloc>(context)
                                    .add(HireInquirer(hiringRequest));
                              }
                            },
                            child: AvailableInquirer(
                                inquirer: state.inquirers[index]),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            SizedBox(height: screenHeight * 0.02),
                      );
                    }

                    // Return Loading by default
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ),
            const CancelButton(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    try {
      BlocProvider.of<ClientBloc>(context).add(StopFindAvailableInquirer());
      // ignore: empty_catches
    } catch (e) {}

    super.dispose();
  }
}
