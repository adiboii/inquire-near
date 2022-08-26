import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:inquire_near/components/buttons.dart';
import 'package:inquire_near/components/inquiry_and_response.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class ResponsesScreen extends StatelessWidget {
  const ResponsesScreen({Key? key}) : super(key: key);

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
                AutoSizeText(
                  'Your Inquries',
                  style: theme.headline,
                ),
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                Expanded(
                  child: InquiryAndResponse(),
                ),
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                ButtonOutline(
                  label: 'Finish',
                  height: screenHeight * 0.07,
                  style: theme.caption1_bold,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
