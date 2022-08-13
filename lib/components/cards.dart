import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

import 'buttons.dart';

class AddInquiryCard extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;
  VoidCallback? onTap;

  AddInquiryCard({
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
          padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  SvgPicture.asset("assets/images/svgs/add_inquiry.svg"),
                  SizedBox(width: 10),
                  Text(
                    "Start by adding an inquiry",
                    style: theme.headline,
                  ),
                ],
              ),
              Text(
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
