import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:inquire_near/components/InquiryImage.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class ViewSelectedInquiryScreen extends StatelessWidget {
  const ViewSelectedInquiryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Screen Dimensions
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: theme.kScreenPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    children: const [
                      BackButton(),
                      AutoSizeText(
                        'Inquiry 1',
                        style: theme.headline,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: screenHeight * 0.02,
                        backgroundImage: AssetImage(
                          'assets/images/illustrations/profile.png',
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.02,
                      ),
                      AutoSizeText(
                        'Is it open right now?',
                        style: theme.subhead,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.1,
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: screenHeight * 0.02,
                        backgroundImage: AssetImage(
                          'assets/images/illustrations/profile.png',
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.02,
                      ),
                      AutoSizeText(
                        'Yes',
                        style: theme.subhead,
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.image,
                        color: theme.primary,
                      ),
                      SizedBox(
                        width: screenWidth * 0.02,
                      ),
                      AutoSizeText(
                        'Upload photo',
                        style: theme.callout,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: screenHeight * 0.037,
                        height: screenHeight * 0.02,
                        child: Checkbox(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              4.0,
                            ),
                          ),
                          value: false,
                          onChanged: (value) {},
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.02,
                      ),
                      AutoSizeText(
                        'Proof',
                        style: theme.callout,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
