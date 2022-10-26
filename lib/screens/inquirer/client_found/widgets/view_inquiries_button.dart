// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:inquire_near/bloc/bloc/Inquiry/inquiry_bloc.dart';
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
      BlocProvider.of<InquiryBloc>(context)
          .add(GetClientInquiries(inquiryListID: id));
      Navigator.pushNamed(context, '/client_inquiry_list');
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
