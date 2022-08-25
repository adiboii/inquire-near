import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:inquire_near/components/bordered_profile_picture.dart';
import 'package:inquire_near/components/buttons.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class ClientFoundScreen extends StatelessWidget {
  const ClientFoundScreen({Key? key}) : super(key: key);

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
              children: <Widget>[
                Column(
                  children: [
                    AutoSizeText(
                      'You\'re Hired',
                      style: theme.headline,
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    BorderedProfilePicture(),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    AutoSizeText(
                      'Mel Jefferson Gabutan',
                      style: theme.subhead_bold,
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star,
                          color: theme.primaryYellow,
                          size: theme.caption2Icon,
                        ),
                        SizedBox(
                          width: screenWidth * 0.01,
                        ),
                        AutoSizeText(
                          '4.5 (12 reviews)',
                          style: theme.caption2,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * 0.05,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: theme.primary,
                          size: theme.subheadIcon,
                        ),
                        SizedBox(
                          width: screenWidth * 0.02,
                        ),
                        AutoSizeText(
                          'Location',
                          style: theme.subhead_bold,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * 0.015,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: screenWidth * 0.071,
                        ),
                        Image.asset(
                          'assets/images/logos/BIR.png',
                          width: screenWidth * 0.1,
                        ),
                        SizedBox(
                          width: screenWidth * 0.03,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            AutoSizeText(
                              'Bureau of Internal Revenue (BIR)',
                              style: theme.caption1,
                            ),
                            AutoSizeText(
                              'Cebu South Branch',
                              style: theme.caption1,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.receipt,
                          color: theme.primary,
                          size: theme.subheadIcon,
                        ),
                        SizedBox(
                          width: screenWidth * 0.02,
                        ),
                        AutoSizeText(
                          'Order',
                          style: theme.subhead_bold,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * 0.015,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        AutoSizeText(
                          'Inquiries',
                          style: theme.caption1,
                        ),
                        AutoSizeText(
                          '4 x PHP 25.00',
                          style: theme.caption1,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        AutoSizeText(
                          'Require Proof',
                          style: theme.caption1,
                        ),
                        AutoSizeText(
                          '4 x PHP 5.00',
                          style: theme.caption1,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    Divider(
                      thickness: 0.9,
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        AutoSizeText(
                          'Total Amount',
                          style: theme.caption1,
                        ),
                        AutoSizeText(
                          'PHP 100.00',
                          style: theme.headline,
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    ButtonFill(
                      label: 'Accept Request',
                      style: theme.caption1_bold,
                      height: screenHeight * 0.07,
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed(
                          '/reminders',
                        );
                      },
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    ButtonOutline(
                      label: 'Reject Request',
                      style: theme.caption1_bold,
                      height: screenHeight * 0.07,
                      color: theme.red,
                      textColor: theme.red,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
