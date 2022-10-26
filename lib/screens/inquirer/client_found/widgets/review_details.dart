// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';

// Project imports:
import 'package:inquire_near/themes/app_theme.dart' as theme;

class ReviewDetails extends StatelessWidget {
  const ReviewDetails({
    Key? key,
    required this.screenWidth,
    required this.numberOfFeedbacks,
    required this.reviewDetails,
  }) : super(key: key);

  final double screenWidth;
  final int numberOfFeedbacks;
  final String reviewDetails;

  @override
  Widget build(BuildContext context) {
    return Row(
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
        AutoSizeText(
          numberOfFeedbacks != 0 ? reviewDetails : "No reviews yet",
          style: theme.caption2,
        ),
      ],
    );
  }
}
