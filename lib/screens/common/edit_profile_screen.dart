// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:inquire_near/bloc/bloc/auth/auth_bloc.dart';
import 'package:inquire_near/components/buttons.dart';
import 'package:inquire_near/components/input_field.dart';
import 'package:inquire_near/components/input_validator.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  // Text Controllers
  final TextEditingController firstNameTextController = TextEditingController();
  final TextEditingController lastNameTextController = TextEditingController();

  // Form Key
  final formKey = GlobalKey<FormState>();

  // Input Validator
  final inputValidator = InputValidator();

  void _editProfile(context) {
    //TO DO: To change
    if (formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        EditProfileRequested(
          firstNameTextController.text,
          lastNameTextController.text,
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    firstNameTextController.text = BlocProvider.of<AuthBloc>(context).user!.firstName!;
    lastNameTextController.text = BlocProvider.of<AuthBloc>(context).user!.lastName!;

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
          "Edit Profile",
          style: theme.title2,
        ),
        centerTitle: true,
      ),
      body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is Unauthenticated) {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/landing', (route) => false);
            }
          },
          child: SingleChildScrollView(
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
                      _editProfile(context);
                    },
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }
}