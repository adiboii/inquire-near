// Flutter imports:
import 'package:flutter/material.dart';

class IconContainer extends StatelessWidget {
  final String source;
  const IconContainer({super.key, required this.source});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      width: 75,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: IconButton(
          onPressed: () {}, color: Colors.grey[200], icon: Image.asset(source)),
    );
  }
}
