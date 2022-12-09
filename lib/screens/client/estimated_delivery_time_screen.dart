// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inquire_near/bloc/bloc/Inquiry/inquiry_bloc.dart';
import 'package:inquire_near/data/models/transaction.dart';
import 'package:inquire_near/routes.dart';
import 'package:lottie/lottie.dart';

// Project imports:
import 'package:inquire_near/bloc/bloc/transaction/transaction_bloc.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;
import 'package:move_to_background/move_to_background.dart';

class ETAScreen extends StatefulWidget {
  const ETAScreen({Key? key}) : super(key: key);

  @override
  State<ETAScreen> createState() => _ETAScreenState();
}

class _ETAScreenState extends State<ETAScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TransactionBloc>(context).add(ListenForTransactionStatus());
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    INTransaction? transaction;
    return BlocListener<InquiryBloc, InquiryState>(
      listener: (context, state) {
        if (state is ClientInquiriesRetrieved) {
          Navigator.pushNamed(context, transactionInquiryListRoute,
              arguments: true);
        }
      },
      child: BlocListener<TransactionBloc, TransactionState>(
        listener: (context, state) {
          if (state is TransactionCompleted) {
            transaction =
                BlocProvider.of<TransactionBloc>(context).transaction!;

            BlocProvider.of<TransactionBloc>(context)
                .add((ViewRecentTransaction(transaction: transaction!)));
          }

          if (state is RetrievedTransactionDetails) {
            BlocProvider.of<InquiryBloc>(context).add(
                GetClientInquiries(inquiryListID: transaction!.inquiryListId));
          }
        },
        child: WillPopScope(
          onWillPop: () async {
            MoveToBackground.moveTaskToBack();
            return false;
          },
          child: Scaffold(
            body: SafeArea(
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: theme.kScreenPadding,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const Text(
                            'Waiting for Inquirer',
                            style: theme.headline,
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          const Text(
                            "Sit back and relax while our\ninquirer handles things for you.",
                            style: theme.subhead,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: screenHeight * 0.03),
                          Lottie.asset("assets/images/lottie/eta.json",
                              height: screenHeight * 0.30),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
