// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_svg/flutter_svg.dart';

// Project imports:
import 'package:inquire_near/themes/app_theme.dart' as theme;

class UserStatistics extends StatelessWidget {
  const UserStatistics({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.star,
              size: 12,
              color: Colors.amber,
            ),
            SizedBox(width: screenWidth * 0.01),
            data["numberOfFeedbacks"] == 0
                ? const Text(
                    "No reviews yet",
                    style: theme.caption2,
                  )
                : Text(
                    "${data['averageRating']} (${data['numberOfFeedbacks']} reviews)",
                    style: theme.caption2,
                  ),
          ],
        ),
        Row(
          children: [
            SvgPicture.asset("assets/images/svgs/task.svg"),
            SizedBox(width: screenWidth * 0.01),
            SizedBox(width: screenWidth * 0.01),
            Text(
              "Has made ${data['numberOfInquiries']} inquiries",
              style: theme.caption2,
            ),
          ],
        ),
      ],
    );
  }
}
