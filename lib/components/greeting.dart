// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:inquire_near/themes/app_theme.dart' as theme;

class Greeting extends StatelessWidget {
  final String name;
  const Greeting({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Welcome back,",
          style: theme.subhead,
        ),
        Text(
          "$name!",
          style: theme.title3,
        )
      ],
    );
  }
}
