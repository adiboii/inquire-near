// Flutter imports:
import 'dart:developer';

import 'package:flutter/material.dart';

// Project imports:
import 'package:inquire_near/data/models/feedback.dart' as f_model;
import 'package:inquire_near/screens/common/profile_details/widgets/recent_review_item.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;
import 'package:inquire_near/utils.dart' as utils;

class Reviews extends StatelessWidget {
  const Reviews({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    log(data.toString());

    return Padding(
      padding: theme.kScreenPadding.copyWith(top: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Recent Reviews",
            style: theme.calloutBold,
          ),
          SizedBox(height: screenHeight * 0.04),
          data["feedbacks"].length == 0
              ? const Center(
                  child: Text("No reviews yet"),
                )
              : ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: data["feedbacks"].length,
                  itemBuilder: (context, index) {
                    String firstName =
                        data["feedbacks"][index].keys.toList().first;
                    f_model.Feedback feedback =
                        data["feedbacks"][index][firstName];

                    return RecentReviewItem(
                      censoredNamed: utils.censorizeName(firstName),
                      review: feedback.review,
                      rating: feedback.rating,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                )
        ],
      ),
    );
  }
}
