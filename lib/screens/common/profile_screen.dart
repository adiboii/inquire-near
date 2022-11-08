// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:inquire_near/bloc/bloc/auth/auth_bloc.dart';
import 'package:inquire_near/components/buttons.dart';
import 'package:inquire_near/components/labels.dart';
import 'package:inquire_near/routes.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  //Display Deactivate dialog
  showDeactivateDialog(BuildContext context){
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: const Text(
          "Deactivate account",
          style: theme.title3,
        ),
        content: const Text(
            "Are you sure you want to deactivate your account?"
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              Navigator.pop(context, 'Cancel');
            },
            child: Text("Cancel"),
          ),
          MaterialButton(
            onPressed: () {
              //TO DO: update field of user isDeactivate
            },
            child: Text("Confirm"),
          ),
        ],
      );
    });
  }

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
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Unauthenticated) {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(landingRoute, (route) => false);
          }
        },
        child: Padding(
          padding: theme.kScreenPadding.copyWith(top: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 60.0,
                backgroundImage: AssetImage(
                  'assets/images/illustrations/profile.png',
                ),
              ),
              const SizedBox(height: 25.0),
               Text(
                 BlocProvider.of<AuthBloc>(context).user!.firstName! + " " + BlocProvider.of<AuthBloc>(context).user!.lastName!,
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
                onTap: (){
                  showDeactivateDialog(context); 
                },
              ),
              SizedBox(height: screenHeight * 0.04),
              InLabel(
                icon: Icons.info_sharp,
                label: "About InquireNear",
                onTap: () {
                  Navigator.pushNamed(context, '/about_inquirenear');
                },
              ),
              SizedBox(height: screenHeight * 0.04),
              InLabel(
                icon: Icons.exit_to_app,
                label: "Sign Out",
                onTap: () {
                  context.read<AuthBloc>().add(SignOutRequested());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
