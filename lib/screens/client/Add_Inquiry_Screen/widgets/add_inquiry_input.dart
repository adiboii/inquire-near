// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:inquire_near/themes/app_theme.dart' as theme;

class AddInquiryInput extends StatefulWidget {
  const AddInquiryInput({
    Key? key,
    required this.screenWidth,
    required this.inquiryContoller,
    this.validator,
    this.readOnly = false,
  }) : super(key: key);

  final double screenWidth;
  final TextEditingController inquiryContoller;
  final String? Function(String?)? validator;
  final bool readOnly;

  @override
  State<AddInquiryInput> createState() => _AddInquiryInputState();
}

class _AddInquiryInputState extends State<AddInquiryInput> {
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
          child: TextFormField(
            controller: widget.inquiryContoller,
            decoration:
                const InputDecoration.collapsed(hintText: "What do you need?"),
            style: theme.subhead,
            maxLength: 150,
            maxLines: null,
            validator: widget.validator,
            readOnly: widget.readOnly,
          ),
        ),
      ],
    );
  }
}
