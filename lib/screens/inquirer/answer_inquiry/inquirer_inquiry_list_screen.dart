// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:inquire_near/bloc/bloc/Inquiry/inquiry_bloc.dart';
import 'package:inquire_near/components/buttons.dart';
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
  @override
  Widget build(BuildContext context) {
    bool isComplete = true;
    // Screen Dimensions
    double screenHeight = MediaQuery.of(context).size.height;
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
                      ? () {
                          BlocProvider.of<InquiryBloc>(context)
                              .add(AnswerInquiryRequested(
                            inquiryList:
                                BlocProvider.of<InquiryBloc>(context).inquiries,
                          ));
                          Navigator.of(context).pushReplacementNamed(
                            paymentReceivedRoute,
                          );
                        }
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
