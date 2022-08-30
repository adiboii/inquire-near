// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:inquire_near/components/buttons.dart';
import 'package:inquire_near/components/labels.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        title: const Text(
          "Profile",
          style: theme.title2,
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: theme.kScreenPadding.copyWith(top: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                const CircleAvatar(
                  radius: 60.0,
                  backgroundImage: AssetImage(
                    'assets/images/illustrations/profile.png',
                  ),
                ),
                const SizedBox(height: 25.0),
                const Text(
                  'Cymmer John Maranga',
                  style: theme.headline,
                ),
                const SizedBox(height: 10.0),
                ButtonFill(
                  label: "Edit Profile",
                  width: screenWidth * 0.40,
                  height: screenHeight * 0.05,
                  style: theme.caption1,
                  onTap: () {
                    Navigator.pushNamed(context, '/edit_profile');
                  },
                ),
                const SizedBox(height: 5.0),
                ButtonOutline(
                  label: "Deactivate Account",
                  width: screenWidth * 0.40,
                  height: screenHeight * 0.05,
                  style: theme.caption1,
                  color: theme.red,
                  textColor: theme.red,
                ),
              ],
            ),
            const SizedBox(height: 30.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const InLabel(icon: Icons.help, label: "Help Center"),
                SizedBox(height: screenHeight * 0.04),
                const InLabel(icon: Icons.question_answer, label: "FAQ"),
                SizedBox(height: screenHeight * 0.04),
                const InLabel(icon: Icons.lock, label: "Privacy Policy"),
                SizedBox(height: screenHeight * 0.04),
                const InLabel(icon: Icons.notes, label: "Terms of Service"),
                SizedBox(height: screenHeight * 0.04),
                const InLabel(icon: Icons.info_sharp, label: "About Busify"),
                SizedBox(height: screenHeight * 0.04),
                InLabel(
                  icon: Icons.exit_to_app,
                  label: "Sign Out",
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
