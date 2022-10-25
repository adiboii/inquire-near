// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:inquire_near/themes/app_theme.dart' as theme;

class InquiryInput extends StatefulWidget {
  const InquiryInput({
    Key? key,
    required this.screenWidth,
    required this.inquiryContoller,
    this.updateMessage,
  }) : super(key: key);

  final double screenWidth;
  final TextEditingController inquiryContoller;
  final Function(String)? updateMessage;
  @override
  State<InquiryInput> createState() => _InquiryInputState();
}

class _InquiryInputState extends State<InquiryInput> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          child: CircleAvatar(
            radius: widget.screenWidth * 0.05,
            backgroundImage: const AssetImage(
              'assets/images/illustrations/profile.png',
            ),
          ),
        ),
        SizedBox(width: widget.screenWidth * 0.04),
        SizedBox(
          width: widget.screenWidth * 0.7,
          child: TextField(
            controller: widget.inquiryContoller,
            onChanged: widget.updateMessage,
            decoration:
                //TODO: find a way to
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
