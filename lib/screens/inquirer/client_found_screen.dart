// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';

// Project imports:
import 'package:inquire_near/components/bordered_profile_picture.dart';
import 'package:inquire_near/components/buttons.dart';
import 'package:inquire_near/components/location_and_order_details.dart';
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
                    const AutoSizeText(
                      'You\'re Hired',
                      style: theme.headline,
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    const BorderedProfilePicture(),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    const AutoSizeText(
                      'Mel Jefferson Gabutan',
                      style: theme.subheadBold,
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.star,
                          color: theme.primaryYellow,
                          size: theme.caption2Icon,
                        ),
                        SizedBox(
                          width: screenWidth * 0.01,
                        ),
                        const AutoSizeText(
                          '4.5 (12 reviews)',
                          style: theme.caption2,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * 0.05,
                    ),
                    const LocationAndOrderDetails(),
                  ],
                ),
                Column(
                  children: [
                    ButtonFill(
                      label: 'Accept Request',
                      style: theme.caption1Bold,
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
                      style: theme.caption1Bold,
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
