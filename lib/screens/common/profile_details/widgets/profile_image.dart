// Flutter imports:
import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: screenWidth * 0.12,
      child: CircleAvatar(
        radius: screenWidth * 0.11,
        backgroundImage:
            const AssetImage("assets/images/illustrations/profile.png"),
      ),
    );
  }
}
