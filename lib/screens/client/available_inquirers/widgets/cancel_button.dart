// Flutter imports:
import 'package:flutter/material.dart';

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
          Navigator.pop(context);
        },
      ),
    );
  }
}
