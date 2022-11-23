// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:inquire_near/components/buttons.dart';
import 'package:inquire_near/components/google_button.dart';
import 'package:inquire_near/components/input_field.dart';
import 'package:inquire_near/components/input_validator.dart';
import 'package:inquire_near/routes.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;
import '../../bloc/bloc/auth/auth_bloc.dart';

class SignUpScreen extends StatelessWidget {
  // Properties
  // Text Controllers
  final firstNameTextController = TextEditingController();
  final lastNameTextController = TextEditingController();
  final emailAddressTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();

  // Form Key
  final formKey = GlobalKey<FormState>();

  // Input Validator
  final inputValidator = InputValidator();

  // Constructors
  SignUpScreen({Key? key}) : super(key: key);

  void _authenticateWithEmailAndPassword(context) {
    if (formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        SignUpRequested(
          firstNameTextController.text,
          lastNameTextController.text,
          emailAddressTextController.text,
          passwordTextController.text,
        ),
      );
    }
  }

  void _authenticateWithGoogle(context) {
    BlocProvider.of<AuthBloc>(context).add(
      GoogleSignInRequested(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Screen Dimensions
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.of(context).pushNamed(
              state.isFromSignup ? paypalAccountRoute : clientDashboardRoute,
            );
          }

          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is Unauthenticated) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: theme.kScreenPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          BackButton(),
                          AutoSizeText(
                            "Create a new account",
                            style: theme.title3,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenHeight * 0.03,
                      ),
                      const Center(
                        child: AutoSizeText(
                          "Use your Google account",
                          style: theme.caption1,
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.04,
                      ),
                      Center(
                        child: GoogleButton(
                          logoSource: "assets/images/logos/Google.png",
                          onTap: () {
                            _authenticateWithGoogle(context);
                          },
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      const Center(
                        child: AutoSizeText(
                          'or',
                          style: theme.caption1,
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
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
                            InputField(
                              label: 'Email Address',
                              controller: emailAddressTextController,
                              icon: Icons.email,
                              validator: (value) {
                                if (!inputValidator.isEmpty(value)) {
                                  if (!inputValidator
                                      .isValidEmailAddress(value)) {
                                    return 'Invalid Email Address format';
                                  }
                                } else {
                                  return 'Email Address is a required field';
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
                            InputField(
                              label: 'Confirm Password',
                              controller: confirmPasswordTextController,
                              icon: Icons.lock,
                              isPassword: true,
                              validator: (value) {
                                if (!inputValidator.isEmpty(value)) {
                                  if (passwordTextController.text !=
                                      confirmPasswordTextController.text) {
                                    return 'Passwords did not match';
                                  }
                                } else {
                                  return 'Confirm Password is a required field';
                                }

                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.025,
                      ),
                      ButtonFill(
                        label: "Create Account",
                        onTap: () {
                          _authenticateWithEmailAndPassword(context);
                          Navigator.of(context).pushNamed(paypalAccountRoute);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
