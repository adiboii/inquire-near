// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:inquire_near/themes/app_theme.dart' as theme;

class StoreContainer extends StatelessWidget {
  const StoreContainer({
    super.key,
    required this.imageFilePath,
  });
  final String imageFilePath;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * 0.15,
      width: screenHeight * 0.15,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: Offset(screenHeight * 0.007, screenHeight * 0.007),
          ),
        ],
      ),
      child: Padding(
        padding: theme.kCardPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                child: Image.asset(imageFilePath),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
