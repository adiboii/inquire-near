// Flutter imports:
import 'package:flutter/material.dart';

class IconContainer extends StatelessWidget {
  // Properties
  final String source;

  // Constructor
  const IconContainer({
    super.key,
    required this.source,
  });

  // Build Method
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: screenHeight * 0.1,
        width: screenHeight * 0.1,
        padding: EdgeInsets.all(
          screenHeight * 0.02,
        ),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: const BorderRadius.all(
            Radius.circular(
              10,
            ),
          ),
        ),
        child: Image.asset(
          source,
        ),
      ),
    );
  }
}
