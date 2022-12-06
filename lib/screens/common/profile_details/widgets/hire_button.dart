// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:inquire_near/components/buttons.dart';
import 'package:inquire_near/screens/common/custom_alert_dialog.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class HireButton extends StatelessWidget {
  const HireButton({
    Key? key,
  }) : super(key: key);

  showAlertDialog(BuildContext context) async {
    // show the dialog
    bool result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          title: 'Hire Inquirer',
          content: 'Do you want to hire this inquirer?',
          successText: 'Yes',
          onSuccess: () {
            Navigator.pop(context, true);
          },
          failText: 'Cancel',
          onFail: () {
            Navigator.pop(context, false);
          },
        );
      },
    );

    if (result) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: ButtonOutline(
        label: "Hire Inquirer",
        style: theme.caption1,
        color: theme.primary,
        textColor: theme.primary,
        onTap: () async {
          showAlertDialog(context);
        },
      ),
    );
  }
}
