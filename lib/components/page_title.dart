import 'package:flutter/material.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class PageTitle extends StatelessWidget {
  final String title;
  const PageTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
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
