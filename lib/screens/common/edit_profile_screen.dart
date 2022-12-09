// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:inquire_near/bloc/bloc/auth/auth_bloc.dart';
import 'package:inquire_near/components/buttons.dart';
import 'package:inquire_near/components/input_field.dart';
import 'package:inquire_near/components/input_validator.dart';
import 'package:inquire_near/components/page_title.dart';
import 'package:inquire_near/routes.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // Text Controllers
  final TextEditingController firstNameTextController = TextEditingController();

  final TextEditingController lastNameTextController = TextEditingController();

  // Form Key
  final formKey = GlobalKey<FormState>();

  // Input Validator
  final inputValidator = InputValidator();

  @override
  void initState() {
    super.initState();
    firstNameTextController.text =
        BlocProvider.of<AuthBloc>(context).user!.firstName!;
    lastNameTextController.text =
        BlocProvider.of<AuthBloc>(context).user!.lastName!;
  }

  void _editProfile(context) {
    if (formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        EditProfileRequested(
          firstNameTextController.text,
          lastNameTextController.text,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Successfully Edited Profile!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: theme.kScreenPadding.copyWith(top: 20),
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is Unauthenticated) {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(landingRoute, (route) => false);
              }

              if (state is EditedProfile) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    clientDashboardRoute, (route) => false);
                BlocProvider.of<AuthBloc>(context).add(InitState());
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PageTitle(
                    title: "Edit Profile",
                    onTap: () {
                      Navigator.pop(context);
                    }),
                const CircleAvatar(
                  radius: 60.0,
                  backgroundImage: AssetImage(
                    'assets/images/illustrations/profile.png',
                  ),
                ),
                const SizedBox(height: 25.0),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      InputField(
                        label: 'First Name',
                        controller: firstNameTextController,
                        icon: Icons.person,
                        validator: (value) {
                          if (!inputValidator.isEmpty(value)) {
                            if (!inputValidator.isValidName(value)) {
                              return 'First Name must only contain alphanumeric characters';
                            }
                          } else {
                            return 'First Name is a required field';
                          }
                          return null;
                        },
                      ),
                      InputField(
                        label: 'Last Name',
                        controller: lastNameTextController,
                        icon: Icons.person,
                        validator: (value) {
                          if (!inputValidator.isEmpty(value)) {
                            if (!inputValidator.isValidName(value)) {
                              return 'Last Name must only contain alphanumeric characters';
                            }
                          } else {
                            return 'Last Name is a required field';
                          }

                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),
                ButtonFill(
                  label: "Save",
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    _editProfile(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    firstNameTextController.dispose();
    lastNameTextController.dispose();
    super.dispose();
  }
}
