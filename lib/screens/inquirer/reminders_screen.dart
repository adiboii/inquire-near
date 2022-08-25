import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class RemindersScreen extends StatelessWidget {
  const RemindersScreen({Key? key}) : super(key: key);

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
              children: [
                AutoSizeText(
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
                AutoSizeText(
                  'Reminders:',
                  style: theme.subhead_bold,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
