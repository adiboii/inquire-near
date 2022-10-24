// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_svg/flutter_svg.dart';

// Project imports:
import 'package:inquire_near/components/buttons.dart';
import 'package:inquire_near/data/models/inquiry.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class InquiryTitleBar extends StatelessWidget {
  const InquiryTitleBar({
    Key? key,
    required this.screenWidth,
    required this.screenHeight,
    required this.onTap,
    required this.label,
    required this.buttonLabel,
  }) : super(key: key);

  final double screenWidth;
  final double screenHeight;
  final Function() onTap;
  final String label;
  final String buttonLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //TODO: change to icon
        Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: SvgPicture.asset("assets/images/svgs/cancel.svg"),
            ),
            SizedBox(width: screenWidth * 0.04),
            SvgPicture.asset("assets/images/svgs/add_inquiry.svg"),
            SizedBox(width: screenWidth * 0.04),
            Text(
              label,
              style: theme.headline,
            ),
          ],
        ),

        ButtonFill(
          label: buttonLabel,
          width: screenWidth * 0.25,
          height: screenHeight * 0.05,
          style: theme.caption1Bold,
          borderRadius: 5,
          onTap: onTap,
        ),
      ],
    );
  }
}
