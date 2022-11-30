// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:inquire_near/components/back_button.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class PageTitle extends StatelessWidget {
  final String title;
  final bool showButton;
  final void Function()? onTap;
  const PageTitle({
    Key? key,
    required this.title,
    required this.onTap,
    this.showButton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        (showButton)
            ? Align(
                alignment: Alignment.centerLeft,
                child: INBackButton(
                  size: 25,
                  onTap: onTap,
                ))
            : const SizedBox(),
        Text(
          title,
          style: theme.headline,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
