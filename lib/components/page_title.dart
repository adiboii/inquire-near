// Flutter imports:
import 'package:flutter/material.dart';

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: onTap,
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        Text(
          title,
          style: theme.headline,
        ),
        const SizedBox()
      ],
    );
  }
}
