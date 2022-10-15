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
          fit: BoxFit.cover,
          image: NetworkImage(
              "https://images.unsplash.com/photo-1599173704879-2e407aa34cde?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80"),
        ),
      ),
    );
  }
}
