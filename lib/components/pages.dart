// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:inquire_near/themes/app_theme.dart' as theme;

class OnboardingPage extends StatelessWidget {
  final String imageURL;
  final String title;
  final String subtitle;

  const OnboardingPage(
      {super.key,
      required this.imageURL,
      required this.title,
      required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 70),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage(imageURL),
            width: 250,
          ),
          SizedBox(height: screenHeight * 0.1),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.title1,
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                subtitle,
                style: theme.body,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
