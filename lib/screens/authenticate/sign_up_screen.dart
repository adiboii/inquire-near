// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:inquire_near/components/buttons.dart';
import 'package:inquire_near/components/icon_container.dart';
import 'package:inquire_near/components/input_field.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;
import '../../bloc/bloc/auth_bloc.dart';

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

  // Constructors
  SignUpScreen({Key? key}) : super(key: key);

  void _authenticateWithEmailAndPassword(context) {
    if (formKey.currentState!.validate()) {
      // If email is valid adding new event [SignUpRequested].
      BlocProvider.of<AuthBloc>(context).add(
        SignUpRequested(
          emailAddressTextController.text,
          passwordTextController.text,
        ),
      );
    }
  }

  // TODO: Use this functionality for Google SSO (Socials Login)
  // void _authenticateWithGoogle(context) {
  //   BlocProvider.of<AuthBloc>(context).add(
  //     GoogleSignInRequested(),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.of(context).pushNamed(
              '/client_dashboard',
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
                      const AutoSizeText(
                        "Create a new account",
                        style: theme.title3,
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
                      const Center(
                        child: IconContainer(
                          source: "assets/images/logos/Google.png",
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
                            ),
                            InputField(
                              label: 'Last Name',
                              controller: lastNameTextController,
                              icon: Icons.person,
                            ),
                            InputField(
                              label: 'Email Address',
                              controller: emailAddressTextController,
                              icon: Icons.email,
                            ),
                            InputField(
                              label: 'Password',
                              controller: passwordTextController,
                              icon: Icons.lock,
                              isPassword: true,
                            ),
                            InputField(
                              label: 'Confirm Password',
                              controller: confirmPasswordTextController,
                              icon: Icons.lock,
                              isPassword: true,
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
