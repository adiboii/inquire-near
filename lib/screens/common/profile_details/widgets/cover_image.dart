// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:inquire_near/themes/app_theme.dart' as theme;

class CoverImage extends StatelessWidget {
  const CoverImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: const BoxDecoration(
        color: theme.primary,
        image: DecorationImage(
          fit: BoxFit.fitHeight,
          image: AssetImage("assets/images/illustrations/banner.jpg"),
        ),
      ),
    );
  }
}
