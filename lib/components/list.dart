// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:inquire_near/themes/app_theme.dart' as theme;

class InListItem extends StatelessWidget {
  final Color color;
  final String type;
  final String amount;

  const InListItem(
      {super.key,
      required this.color,
      required this.type,
      required this.amount});
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(
          height: screenHeight * 0.015,
        ),
        Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: theme.primaryGray,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(15)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: color,
                    radius: 5,
                  ),
                  const SizedBox(width: 10),
                  Text(type),
                ],
              ),
              Text(amount),
            ],
          ),
        ),
      ],
    );
  }
}
