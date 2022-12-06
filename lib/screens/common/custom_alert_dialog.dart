import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.content,
    required this.successText,
    required this.onSuccess,
    required this.failText,
    required this.onFail,
  });

  final String title;
  final String content;
  final String successText;
  final void Function()? onSuccess;
  final String failText;
  final void Function()? onFail;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: onSuccess,
          child: Text(successText),
        ),
        TextButton(
          onPressed: onFail,
          child: Text(failText),
        ),
      ],
    );
  }
}
