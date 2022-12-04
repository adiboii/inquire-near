// Flutter imports:

import 'dart:developer';

import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:inquire_near/bloc/bloc/Inquiry/inquiry_bloc.dart';
import 'package:inquire_near/bloc/bloc/auth/auth_bloc.dart';
import 'package:inquire_near/bloc/bloc/client/client_bloc.dart';
import 'package:inquire_near/bloc/bloc/payment/payment_bloc.dart';
import 'package:inquire_near/bloc/bloc/transaction/transaction_bloc.dart';
import 'package:inquire_near/components/buttons.dart';
import 'package:inquire_near/data/models/in_user.dart';
import 'package:inquire_near/data/models/inquiry.dart';
import 'package:inquire_near/data/models/transaction.dart';
import 'package:inquire_near/routes.dart';
import 'package:inquire_near/screens/inquirer/answer_inquiry/widgets/inquiry_tiles_container.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class InquirerInquiryListScreen extends StatefulWidget {
  const InquirerInquiryListScreen({Key? key}) : super(key: key);

  @override
  State<InquirerInquiryListScreen> createState() =>
      _InquirerInquiryListScreenState();
}

class _InquirerInquiryListScreenState extends State<InquirerInquiryListScreen> {
  List<Inquiry>? inquiries;
  bool isComplete = false;

  @override
  Widget build(BuildContext context) {
    inquiries = BlocProvider.of<InquiryBloc>(context).inquiries;
    // Screen Dimensions
    double screenHeight = MediaQuery.of(context).size.height;
    return BlocConsumer<InquiryBloc, InquiryState>(
      listener: (context, state) {
        if (state is AnsweredInquiry) {
          for (Inquiry inquiry in inquiries!) {
            if (inquiry.answerMessage == null) {
              return;
            }
          }
          isComplete = true;
          setState(() {});
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: theme.kScreenPadding,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const AutoSizeText(
                      'Client\'s Inquiries',
                      style: theme.headline,
                    ),
                    SizedBox(
                      height: screenHeight * 0.04,
                    ),
                    const Expanded(child: InquiryTilesContainer()),
                    SizedBox(
                      height: screenHeight * 0.04,
                    ),
                    ButtonFill(
                      label: 'Finish',
                      style: theme.caption1Bold,
                      height: screenHeight * 0.07,
                      color: (isComplete) ? theme.primary : theme.primaryGray,
                      onTap: (isComplete)
                          ? () async {
                              BlocProvider.of<InquiryBloc>(context)
                                  .add(AnswerInquiryRequested(
                                inquiryList:
                                    BlocProvider.of<InquiryBloc>(context)
                                        .inquiries,
                              ));

                              INTransaction? transaction =
                                  BlocProvider.of<TransactionBloc>(context)
                                      .transaction;

                              INUser? user =
                                  BlocProvider.of<AuthBloc>(context).user;

                              // Get client from transaction
                              INUser? client =
                                  await BlocProvider.of<ClientBloc>(context)
                                      .getClient(transaction!.clientId);

                              // ignore: use_build_context_synchronously
                              BlocProvider.of<PaymentBloc>(context).add(
                                Payout(
                                    client!.paypalAddress.toString(),
                                    transaction.id!,
                                    user!.paypalAddress!,
                                    transaction.amount!),
                              );

                              // ignore: use_build_context_synchronously
                              BlocProvider.of<TransactionBloc>(context)
                                  .add(FinishTransaction());

                              // ignore: use_build_context_synchronously
                              Navigator.of(context).pushReplacementNamed(
                                paymentReceivedRoute,
                              );
                            }
                          : () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please answer all inquiries'),
                                ),
                              );
                            },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
