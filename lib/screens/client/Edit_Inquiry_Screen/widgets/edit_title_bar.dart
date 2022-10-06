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

class TitleBar extends StatelessWidget {
  const TitleBar({
    Key? key,
    required this.inquiry,
    required this.screenWidth,
    required this.screenHeight,
    required this.inquiryContoller,
    required this.requireProof,
    required this.image,
  }) : super(key: key);

  final Inquiry inquiry;
  final double screenWidth;
  final double screenHeight;

  final TextEditingController inquiryContoller;

  final bool requireProof;

  final File? image;

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
                Navigator.pop(context, inquiry);
              },
              child: SvgPicture.asset("assets/images/svgs/cancel.svg"),
            ),
            SizedBox(width: screenWidth * 0.04),
            SvgPicture.asset("assets/images/svgs/add_inquiry.svg"),
            SizedBox(width: screenWidth * 0.04),
            const Text(
              "Edit inquiry",
              style: theme.headline,
            ),
          ],
        ),

        ButtonFill(
          label: "Edit inquiry",
          width: screenWidth * 0.25,
          height: screenHeight * 0.05,
          style: theme.caption1Bold,
          borderRadius: 5,
          onTap: () {
            inquiry.question = inquiryContoller.text;
            inquiry.requiresProof = requireProof;
            inquiry.image = image;

            Navigator.pop(context, inquiry);
          },
        ),
      ],
    );
  }
}
