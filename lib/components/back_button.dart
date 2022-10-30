// Flutter imports:
import 'package:flutter/material.dart';

class INBackButton extends StatelessWidget {
  final Color? color;
  final double size;
  const INBackButton({Key? key, this.color = Colors.black, this.size = 12})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back_rounded,
        color: color,
        size: size,
      ),
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}
