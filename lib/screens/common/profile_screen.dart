import 'package:flutter/material.dart';
import 'package:inquire_near/components/buttons.dart';
import 'package:inquire_near/components/labels.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        title: Text(
          "Profile",
          style: Theme.of(context).textTheme.headline2,
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                CircleAvatar(
                  radius: 60.0,
                  backgroundImage: AssetImage(
                    'assets/images/illustrations/profile.png',
                  ),
                ),
                SizedBox(
                  height: 25.0,
                ),
                Text(
                  'Cymmer John Maranga',
                  style: Theme.of(context).textTheme.headline3,
                ),
                SizedBox(height: 10.0),
                ButtonFill(
                  label: "Edit ProfileScreen",
                  width: 210,
                  onTap: () {
                    Navigator.pushNamed(context, '/edit_profile');
                  },
                ),
                SizedBox(height: 5.0),
                ButtonFill(
                  label: "Deactivate Account",
                  width: 210,
                  color: theme.red,
                ),
              ],
            ),
            SizedBox(height: 30.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                inLabel(icon: Icons.help, label: "Help Center"),
                SizedBox(height: 20),
                inLabel(icon: Icons.question_answer, label: "FAQ"),
                SizedBox(height: 20),
                inLabel(icon: Icons.lock, label: "Privacy Policy"),
                SizedBox(height: 20),
                inLabel(icon: Icons.notes, label: "Terms of Service"),
                SizedBox(height: 20),
                inLabel(icon: Icons.info_sharp, label: "About Busify"),
                SizedBox(height: 20),
                inLabel(
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
