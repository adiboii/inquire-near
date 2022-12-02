// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inquire_near/bloc/bloc/transaction/transaction_bloc.dart';

// Project imports:
import 'package:inquire_near/components/buttons.dart';
import 'package:inquire_near/components/page_title.dart';
import 'package:inquire_near/enums/role.dart';
import 'package:inquire_near/routes.dart';
import 'package:inquire_near/screens/common/recent_transactions/completed_inquiry_list.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class TransactionInquiryListScreen extends StatelessWidget {
  final bool isOngoing;
  const TransactionInquiryListScreen({Key? key, required this.isOngoing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TransactionBloc transactionBloc = BlocProvider.of<TransactionBloc>(context);

    String clientId = transactionBloc.transaction!.clientId;
    String inquirerId = transactionBloc.transaction!.inquirerId!;

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: theme.kScreenPadding.copyWith(top: 5),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PageTitle(
                  title: "Inquiries",
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                  height: screenHeight * 0.04,
                ),
                Expanded(
                  child: CompletedInquiryList(
                      screenHeight: screenHeight, screenWidth: screenWidth),
                ),
                SizedBox(
                  height: screenHeight * 0.04,
                ),
                ButtonFill(
                  label: 'Finish',
                  style: theme.caption1Bold,
                  height: screenHeight * 0.07,
                  onTap: () {
                    if (isOngoing) {
                      Navigator.of(context).pushNamed(reviewClientRoute,
                          arguments: {
                            'toFeedbackId': inquirerId,
                            'feedbacker': clientId
                          });
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
