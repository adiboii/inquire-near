import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inquire_near/bloc/bloc/Inquiry/inquiry_bloc.dart';

// Project imports:
import 'package:inquire_near/components/buttons.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class CancelButton extends StatelessWidget {
  const CancelButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: ButtonOutline(
        label: "Cancel",
        style: theme.caption1,
        color: theme.red,
        textColor: theme.red,
        onTap: () {
          BlocProvider.of<InquiryBloc>(context).add(RevisitInquiry());
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
