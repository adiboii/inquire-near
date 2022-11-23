// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:inquire_near/bloc/bloc/Inquiry/inquiry_bloc.dart';
import 'package:inquire_near/routes.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class ViewInquiriesButton extends StatelessWidget {
  final String inquiryListID;

  const ViewInquiriesButton({
    Key? key,
    required this.inquiryListID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void getClientInquiries(String id) {
      Navigator.pushNamed(context, clientInquiryListRoute);
    }

    return GestureDetector(
      onTap: () {
        getClientInquiries(inquiryListID);
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "View Inquiries",
              style: theme.caption2Bold.copyWith(color: theme.primary),
            ),
            const Icon(
              Icons.arrow_forward_rounded,
              size: theme.caption2Icon,
              color: theme.primary,
            ),
          ],
        ),
      ),
    );
  }
}
