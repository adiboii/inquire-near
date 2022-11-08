// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_svg/flutter_svg.dart';

// Project imports:
import 'package:inquire_near/components/back_button.dart';
import 'package:inquire_near/components/buttons.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class InquiryTitleBar extends StatelessWidget {
  const InquiryTitleBar({
    Key? key,
    required this.screenWidth,
    required this.screenHeight,
    required this.buttonLabel,
    required this.pageLabel,
    required this.onTap,
    this.showButton = false,
  }) : super(key: key);

  final double screenWidth;
  final double screenHeight;
  final String buttonLabel;
  final String pageLabel;
  final void Function() onTap;
  final bool showButton;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const INBackButton(size: 24),
            Row(
              children: [
                SvgPicture.asset("assets/images/svgs/add_inquiry.svg"),
                SizedBox(width: screenWidth * 0.04),
                Text(
                  pageLabel,
                  style: theme.headline,
                ),
              ],
            ),
          ],
        ),
        (showButton)
            ? ButtonFill(
                label: buttonLabel,
                width: screenWidth * 0.25,
                height: screenHeight * 0.05,
                style: theme.caption1Bold,
                borderRadius: 5,
                onTap: onTap,
              )
            : const SizedBox(),
      ],
    );
  }
}
