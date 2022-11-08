// Flutter imports:
import 'package:flutter/material.dart';
import 'package:inquire_near/components/back_button.dart';

// Project imports:
import 'package:inquire_near/themes/app_theme.dart' as theme;

class PageTitle extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  const PageTitle({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const Align(
            alignment: Alignment.centerLeft, child: INBackButton(size: 25)),
        Text(
          title,
          style: theme.headline,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
