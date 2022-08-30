import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class Response extends StatelessWidget {
  const Response({
    Key? key,
    required this.answer,
    this.nAttachedPhotos = 0,
  }) : super(key: key);
  final String answer;
  final int nAttachedPhotos;

  @override
  Widget build(BuildContext context) {
    // Screen Dimensions
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            AutoSizeText(
              answer,
              style: theme.subhead,
            ),
            AutoSizeText(
              'Attached photos: $nAttachedPhotos',
              style: theme.caption2,
            ),
          ],
        ),
        SizedBox(
          width: screenWidth * 0.02,
        ),
        CircleAvatar(
          radius: screenHeight * 0.02,
          backgroundImage: const AssetImage(
            'assets/images/illustrations/profile.png',
          ),
        ),
      ],
    );
  }
}
