// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:inquire_near/components/buttons.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class HireButton extends StatelessWidget {
  const HireButton({
    Key? key,
  }) : super(key: key);

  showAlertDialog(BuildContext context) async {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("Yes"),
      onPressed: () {
        Navigator.pop(context, true);
      },
    );

    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.pop(context, false);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Hire Inquirer"),
      content: const Text("Do you want to hire this inquirer?"),
      actions: [cancelButton, okButton],
    );

    // show the dialog
    bool result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
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
