import 'package:flutter/material.dart';
import 'package:inquire_near/components/buttons.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class RejectRequestButton extends StatelessWidget {
  const RejectRequestButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return ButtonOutline(
      label: 'Reject Request',
      style: theme.caption1Bold,
      height: screenHeight * 0.07,
      color: theme.red,
      textColor: theme.red,
    );
  }
}
