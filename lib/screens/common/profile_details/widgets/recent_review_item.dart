// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:inquire_near/themes/app_theme.dart' as theme;
import 'package:inquire_near/utils.dart' as utils;

class RecentReviewItem extends StatelessWidget {
  final String censoredNamed;
  final String? review;
  final int rating;

  const RecentReviewItem(
      {Key? key,
      required this.censoredNamed,
      required this.review,
      required this.rating
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                  backgroundColor: theme.primary,
                  radius: 16,
                  child: Text(utils.getInitials(censoredNamed),
                      style: const TextStyle(
                          color: theme.buttonText, fontSize: 12))),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    censoredNamed,
                    style: theme.caption1,
                  ),
                  Row(
                      children: List.generate(
                          rating,
                          (_) => const Icon(
                                Icons.star,
                                size: 12,
                                color: Colors.amber,
                              )).toList()),
                  SizedBox(
                    width: screenWidth * 0.70,
                    child: Text(
                      review == null ? "" : review!,
                      style: theme.caption1,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
