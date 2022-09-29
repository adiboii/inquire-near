// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:inquire_near/themes/app_theme.dart' as theme;

class AddInquiryInput extends StatelessWidget {
  const AddInquiryInput({
    Key? key,
    required this.screenWidth,
    required this.inquiryContoller,
  }) : super(key: key);

  final double screenWidth;
  final TextEditingController inquiryContoller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          child: CircleAvatar(
            radius: screenWidth * 0.05,
            backgroundImage: const AssetImage(
              'assets/images/illustrations/profile.png',
            ),
          ),
        ),
        SizedBox(width: screenWidth * 0.04),
        SizedBox(
          width: screenWidth * 0.7,
          child: TextField(
            controller: inquiryContoller,
            decoration:
                const InputDecoration.collapsed(hintText: "What do you need?"),
            style: theme.subhead,
            maxLength: 150,
            maxLines: null,
          ),
        ),
      ],
    );
  }
}
