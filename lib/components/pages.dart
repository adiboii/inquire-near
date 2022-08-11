import 'package:flutter/material.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class OnboardingPage extends StatelessWidget {
  final String imageURL;
  final String title;
  final String subtitle;

  OnboardingPage(
      {required this.imageURL, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage(imageURL),
            width: 250,
          ),
          SizedBox(height: 60),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.title1,
              ),
              SizedBox(height: 20),
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
