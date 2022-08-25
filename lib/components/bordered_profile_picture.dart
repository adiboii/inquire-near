import 'package:flutter/material.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class BorderedProfilePicture extends StatelessWidget {
  const BorderedProfilePicture({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Screen Dimensions
    double screenHeight = MediaQuery.of(context).size.height;

    return CircleAvatar(
      backgroundColor: theme.primary,
      radius: screenHeight * 0.075,
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: screenHeight * 0.073,
        child: CircleAvatar(
          radius: screenHeight * 0.068,
          child: Image.asset(
            'assets/images/illustrations/profile.png',
          ),
        ),
      ),
    );
  }
}
