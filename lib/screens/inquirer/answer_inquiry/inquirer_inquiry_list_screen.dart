// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';

// Project imports:
import 'package:inquire_near/components/buttons.dart';
import 'package:inquire_near/routes.dart';
import 'package:inquire_near/screens/inquirer/answer_inquiry/widgets/inquiry_tile.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class InquirerInquiryListScreen extends StatelessWidget {
  const InquirerInquiryListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                //TODO: Use new inquiry list (ADI)
                const InquiryTile(),
                SizedBox(
                  height: screenHeight * 0.04,
                ),
                ButtonFill(
                  label: 'Finish',
                  style: theme.caption1Bold,
                  height: screenHeight * 0.07,
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed(
                      paymentReceivedRoute,
                    );
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
