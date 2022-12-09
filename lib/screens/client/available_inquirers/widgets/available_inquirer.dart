// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_svg/flutter_svg.dart';

// Project imports:
import 'package:inquire_near/data/models/in_user.dart';
import 'package:inquire_near/data/repositories/user_repository.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;
import 'package:inquire_near/utils.dart' as utils;

class AvailableInquirer extends StatefulWidget {
  final INUser inquirer;
  const AvailableInquirer({Key? key, required this.inquirer}) : super(key: key);

  @override
  State<AvailableInquirer> createState() => _AvailableInquirerState();
}

class _AvailableInquirerState extends State<AvailableInquirer> {
  Future<Map<String, dynamic>> _getUserFeedback(String inquirerId) async {
    Map<String, dynamic> userData =
        await UserRepository().getUserData(inquirerId);

    // Compute average rating
    double ratingSum = 0;
    for (var element in userData['feedbacks']) {
      element.forEach((k, v) {
        ratingSum += v.rating;
      });
    }
    double ratingAverage = ratingSum / userData['feedbacks'].length;

    Map<String, dynamic> computedFeedbackMap = {
      "averageRating": ratingAverage,
      "numberOfFeedbacks": userData['feedbacks'].length
    };

    return computedFeedbackMap;
  }

  @override
  Widget build(BuildContext context) {
    final String name =
        "${widget.inquirer.firstName} ${widget.inquirer.lastName}";

    return FutureBuilder(
      future: _getUserFeedback(widget.inquirer.uid.toString()),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (!snapshot.hasData) return const SizedBox.shrink();

        Map<String, dynamic> computedFeedbackMap = snapshot.data;

        return Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue[800],
              radius: 30,
              child: Text(utils.getInitials(name)),
            ),
            const SizedBox(width: 24),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: theme.subheadBold,
                ),
                const SizedBox(height: 4),
                computedFeedbackMap["numberOfFeedbacks"] != 0
                    ? Row(
                        children: [
                          SvgPicture.asset("assets/images/svgs/star.svg"),
                          Text(
                            "${computedFeedbackMap['averageRating'].toStringAsFixed(1)} (${computedFeedbackMap['numberOfFeedbacks']} reviews)",
                            style: theme.caption2,
                          ),
                        ],
                      )
                    : const Text(
                        "No reviews yet",
                        style: theme.caption2,
                      ),
              ],
            )
          ],
        );
      },
    );
  }
}
