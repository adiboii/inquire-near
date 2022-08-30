// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_svg/svg.dart';

// Project imports:
import 'package:inquire_near/themes/app_theme.dart' as theme;
import 'buttons.dart';

class AddInquiryCard extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;
  final VoidCallback? onTap;

  const AddInquiryCard({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHeight * 0.25,
      width: screenWidth * 0.90,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.lightBlue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  SvgPicture.asset("assets/images/svgs/add_inquiry.svg"),
                  const SizedBox(width: 10),
                  const Text(
                    "Start by adding an inquiry",
                    style: theme.headline,
                  ),
                ],
              ),
              const Text(
                "Make sure to be specific and only ask questions that can be answered",
                style: theme.caption1,
              ),
              ButtonFill(
                label: "Add an inquiry",
                onTap: onTap,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
