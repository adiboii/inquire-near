// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_svg/flutter_svg.dart';

// Project imports:
import 'package:inquire_near/themes/app_theme.dart' as theme;
import 'package:inquire_near/components/buttons.dart';

class AddInquiryTitleBar extends StatelessWidget {
  const AddInquiryTitleBar({
    Key? key,
    required this.screenWidth,
    required this.screenHeight,
    required this.onTap,
  }) : super(key: key);

  final double screenWidth;
  final double screenHeight;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
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
            const Text(
              "Add an inquiry",
              style: theme.headline,
            ),
          ],
        ),
        ButtonFill(
          label: "Add inquiry",
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
