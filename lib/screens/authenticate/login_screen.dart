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

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailAddressTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  final inputValidator = InputValidator();

  final _formKey = GlobalKey<FormState>();

  void _authenticateWithEmailAndPassword(context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        SignInRequested(
            emailAddressTextController.text, passwordTextController.text),
      );
    }
  }

  void _authenticateWithGoogle(context) {
    BlocProvider.of<AuthBloc>(context).add(GoogleSignInRequested());
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
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.of(context).pushNamed('/client_dashboard');
          }

          if (state is AuthError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          if (state is Loading) {
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
                      const Text(
                        "Sign in to your account",
                        style: theme.title3,
                      ),
                      SizedBox(height: screenHeight * 0.05),
                      const Center(
                        child: Text(
                          "Sign In With",
                          style: theme.caption1,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.05),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            _authenticateWithGoogle(context);
                          },
                          child: const Image(
                              width: 50,
                              image:
                                  AssetImage("assets/images/logos/Google.png")),
                        ),
                      ),
                      Form(
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
                      SizedBox(height: screenHeight * 0.05),
                      ButtonFill(
                        label: "Sign In",
                        onTap: () {
                          _authenticateWithEmailAndPassword(context);
                        },
                      ),
                      SizedBox(height: screenHeight * 0.075),
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
