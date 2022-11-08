// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';

// Project imports:
import 'package:inquire_near/routes.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;
import '../../components/buttons.dart';

class RemindersScreen extends StatelessWidget {
  const RemindersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Screen Dimensions
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: theme.kScreenPadding,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const AutoSizeText(
                      'Awesome!',
                      style: theme.headline,
                    ),
                    SizedBox(
                      height: screenHeight * 0.05,
                    ),
                    Image.asset(
                      'assets/images/illustrations/reminders.png',
                      height: screenHeight * 0.22,
                    ),
                    SizedBox(
                      height: screenHeight * 0.05,
                    ),
                    const AutoSizeText(
                      'Reminders:',
                      style: theme.subheadBold,
                    ),
                    SizedBox(
                      height: screenHeight * 0.05,
                    ),
                    SizedBox(
                      width: screenWidth * 0.65,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const AutoSizeText(
                                '•',
                                style: theme.caption1,
                              ),
                              SizedBox(
                                width: screenWidth * 0.01,
                              ),
                              const AutoSizeText(
                                'Be thorough in answering each question',
                                style: theme.caption1,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: screenHeight * 0.01,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const AutoSizeText(
                                '•',
                                style: theme.caption1,
                              ),
                              SizedBox(
                                width: screenWidth * 0.01,
                              ),
                              const AutoSizeText(
                                'Finish the work within 30 minutes or \npayment will be deducted.',
                                style: theme.caption1,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                ButtonFill(
                  label: 'I understand',
                  style: theme.caption1Bold,
                  height: screenHeight * 0.07,
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(inquirerInquiryListRoute);
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
