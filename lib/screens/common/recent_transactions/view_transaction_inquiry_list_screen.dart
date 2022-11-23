// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:inquire_near/components/buttons.dart';
import 'package:inquire_near/components/page_title.dart';
import 'package:inquire_near/screens/common/recent_transactions/completed_inquiry_list.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class TransactionInquiryListScreen extends StatelessWidget {
  const TransactionInquiryListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Screen Dimensions
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
                    Navigator.of(context).pop();
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