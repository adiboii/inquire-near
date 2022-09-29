// Flutter imports:
import 'package:flutter/material.dart';

class GoogleButton extends StatelessWidget {
  // Properties
  final String logoSource;
  final Function onTap;

  // Constructor
  const GoogleButton({
    super.key,
    required this.logoSource,
    required this.onTap,
  });

  // Build Method
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        height: screenHeight * 0.1,
        width: screenHeight * 0.1,
        padding: EdgeInsets.all(
          screenHeight * 0.02,
        ),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: const BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: Image.asset(
          logoSource,
        ),
      ),
    );
  }
}
