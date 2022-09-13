// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// Project imports:
import 'package:inquire_near/components/bordered_profile_picture.dart';
import 'package:inquire_near/components/buttons.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class ReviewClientScreen extends StatelessWidget {
  const ReviewClientScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Screen Dimensions
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: theme.kScreenPadding,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const AutoSizeText(
                        'Tell us about your experience',
                        style: theme.headline,
                      ),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      const AutoSizeText(
                        'Your feedback will help us\nimprove your inquiring needs',
                        textAlign: TextAlign.center,
                        style: theme.footnote,
                      ),
                      SizedBox(
                        height: screenHeight * 0.04,
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
                      RatingBar(
                        ratingWidget: RatingWidget(
                          full: const Icon(
                            Icons.star,
                            color: theme.primaryYellow,
                          ),
                          half: const Icon(
                            Icons.star,
                            color: Colors.grey,
                          ),
                          empty: const Icon(
                            Icons.star,
                            color: Colors.grey,
                          ),
                        ),
                        onRatingUpdate: (rating) {},
                        itemSize: screenHeight * 0.035,
                      ),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                          left: 15.0,
                          right: 15.0,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            4.0,
                          ),
                          border: Border.all(
                            color: Colors.grey,
                          ),
                        ),
                        width: double.infinity,
                        height: screenHeight * 0.38,
                        child: const TextField(
                          decoration: InputDecoration(
                            hintText: 'Leave a Review',
                            hintStyle: theme.caption1,
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.015),
                  ButtonOutline(
                    label: 'Finish',
                    height: screenHeight * 0.07,
                    style: theme.caption1Bold,
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, '/client_dashboard');
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}