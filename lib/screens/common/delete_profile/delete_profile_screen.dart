// Flutter imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:inquire_near/bloc/bloc/auth/auth_bloc.dart';
import 'package:inquire_near/components/buttons.dart';
import 'package:inquire_near/components/input_field.dart';
import 'package:inquire_near/components/input_validator.dart';
import 'package:inquire_near/routes.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class DeleteProfileScreen extends StatefulWidget {
  const DeleteProfileScreen({Key? key}) : super(key: key);

  @override
  State<DeleteProfileScreen> createState() => _DeleteProfileScreenState();
}

class _DeleteProfileScreenState extends State<DeleteProfileScreen> {
  TextEditingController emailAddressTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  final inputValidator = InputValidator();
  final _formKey = GlobalKey<FormState>();
  final String currentUserEmail = FirebaseAuth.instance.currentUser!.email!;

  void _deleteProfile(context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(DeleteProfileRequested(
          email: emailAddressTextController.text,
          password: passwordTextController.text));
    }
  }

  @override
  void dispose() {
    emailAddressTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
      if (state is AuthDeleted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Account successfully deleted."),
        ));
        Navigator.pushNamedAndRemoveUntil(
            context, landingRoute, (route) => false);
      }

      if (state is AuthError) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(state.error),
        ));
      }
    }, builder: (context, state) {
      if (state is AuthLoading) {
        return Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      }

      return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: theme.kScreenPadding,
              height: screenHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("We're sorry to see you go",
                          style: theme.title3),
                      SizedBox(height: screenHeight * 0.01),
                      const Text(
                          "Please enter your credentials to delete your account",
                          style: theme.caption1),
                      SizedBox(height: screenHeight * 0.02),
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: screenHeight * 0.03),
                            InputField(
                              label: 'Email Address',
                              controller: emailAddressTextController,
                              icon: Icons.email,
                              validator: (value) {
                                if (!inputValidator.isEmpty(value)) {
                                  if (!inputValidator
                                      .isValidEmailAddress(value)) {
                                    return 'Invalid Email Address format';
                                  } else if (emailAddressTextController.text !=
                                      currentUserEmail) {
                                    return 'Email does not correspond with current user';
                                  }
                                } else {
                                  return 'Please enter your email address';
                                }

                                return null;
                              },
                            ),
                            InputField(
                              label: 'Password',
                              controller: passwordTextController,
                              icon: Icons.lock,
                              isPassword: true,
                              validator: (value) {
                                if (!inputValidator.isEmpty(value)) {
                                  if (!inputValidator.isValidPassword(value)) {
                                    return 'Password should have at least 6 characters';
                                  }
                                } else {
                                  return 'Password is a required field';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: screenHeight * 0.03),
                    child: Column(
                      children: [
                        ButtonFill(
                          label: "Delete Account",
                          onTap: () {
                            _deleteProfile(context);
                          },
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        ButtonOutline(
                          label: "Cancel",
                          color: theme.red,
                          textColor: theme.red,
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
