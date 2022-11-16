// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:inquire_near/bloc/bloc/auth/auth_bloc.dart';
import 'package:inquire_near/components/buttons.dart';
import 'package:inquire_near/components/labels.dart';
import 'package:inquire_near/components/page_title.dart';
import 'package:inquire_near/routes.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  //Display Delete dialog
  showDeleteDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              "Delete Account",
              style: theme.title3,
            ),
            content:
                const Text("Are you sure you want to delete your account?"),
            actions: [
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context, 'Cancel');
                },
                child: const Text("Cancel"),
              ),
              MaterialButton(
                onPressed: () {
                  //TO DO: update field of user isDeactivate
                  BlocProvider.of<AuthBloc>(context).add(
                    DeactivateProfileRequested(),
                  );
                },
                child: const Text("Confirm"),
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: theme.kScreenPadding.copyWith(top: 20),
            child: BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is Unauthenticated) {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(landingRoute, (route) => false);
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  PageTitle(
                      title: "Profile",
                      onTap: () {
                        Navigator.pop(context);
                      },
                  ),
                  const CircleAvatar(
                    radius: 60.0,
                    backgroundImage: AssetImage(
                      'assets/images/illustrations/profile.png',
                    ),
                  ),
                  const SizedBox(height: 25.0),
                  Text(
                    "${BlocProvider.of<AuthBloc>(context).user!.firstName!} ${BlocProvider.of<AuthBloc>(context).user!.lastName!}",
                    style: theme.headline,
                  ),
                  const SizedBox(height: 10.0),
                  ButtonFill(
                    label: "Edit Profile",
                    width: screenWidth * 0.40,
                    height: screenHeight * 0.05,
                    style: theme.caption1,
                    onTap: () {
                      Navigator.pushNamed(context, editProfileRoute);
                    },
                  ),
                  const SizedBox(height: 5.0),
                  ButtonOutline(
                    label: "Delete Account",
                    width: screenWidth * 0.40,
                    height: screenHeight * 0.05,
                    style: theme.caption1,
                    color: theme.red,
                    textColor: theme.red,
                    onTap: () {
                      showDeleteDialog(context);
                    },
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  InLabel(
                    icon: Icons.info_sharp,
                    label: "About InquireNear",
                    onTap: () {
                      Navigator.pushNamed(context, aboutInquireNearRoute);
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
            ) ,
          ),
        ),
      )

    );
  }
}
