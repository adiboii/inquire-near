// Flutter imports:
import 'dart:developer';

import 'package:flutter/material.dart';

class INBackButton extends StatelessWidget {
  final Color? color;
  final double size;
  final void Function()? onTap;
  const INBackButton(
      {Key? key, this.color = Colors.black, this.size = 12, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back_rounded,
        color: color,
        size: size,
      ),
      onPressed: () {
        if (onTap != null) {
          onTap!();
        } else {
          Navigator.of(context).pop();
        }
      },
    );
  }
}
