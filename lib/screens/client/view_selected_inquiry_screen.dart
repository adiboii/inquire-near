import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

import '../../components/buttons.dart';

class ViewSelectedInquiryScreen extends StatelessWidget {
  const ViewSelectedInquiryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Screen Dimensions
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0,
        leading: const BackButton(
          color: Colors.black,
        ),
        title: const AutoSizeText(
          'Inquiry 1',
          style: theme.headline,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: theme.kScreenPaddingWithAppBar,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: screenHeight * 0.02,
                        backgroundImage: const AssetImage(
                          'assets/images/illustrations/profile.png',
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.02,
                      ),
                      const AutoSizeText(
                        'Is it open right now?',
                        style: theme.subhead,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const AutoSizeText(
                        'Yes',
                        style: theme.subhead,
                      ),
                      SizedBox(
                        width: screenWidth * 0.02,
                      ),
                      CircleAvatar(
                        radius: screenHeight * 0.02,
                        backgroundImage: const AssetImage(
                          'assets/images/illustrations/profile.png',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              ButtonFill(
                label: 'Next Inquiry',
                height: screenHeight * 0.07,
                style: theme.caption1Bold,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
