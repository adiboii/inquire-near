// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:inquire_near/components/buttons.dart';
import 'package:inquire_near/components/container.dart';
import 'package:inquire_near/components/textfield.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

import '../../bloc/bloc/auth_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String confirmPassword = "";
  String email = "";
  String error = "";
  String name = "";
  String password = "";

  final _formKey = GlobalKey<FormState>();

  void _authenticateWithEmailAndPassword(context) {
    if (_formKey.currentState!.validate()) {
      // If email is valid adding new event [SignUpRequested].
      BlocProvider.of<AuthBloc>(context).add(
        SignUpRequested(email, password),
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
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Create a new account",
                            style: theme.title2,
                          ),
                          SizedBox(height: screenHeight * 0.03),
                          const Center(
                            child: Text(
                              "Use your socials",
                              style: theme.subhead,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.04),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const IconContainer(
                                  source: "assets/images/logos/Google.png"),
                              SizedBox(width: screenWidth * 0.04),
                              const IconContainer(
                                  source: "assets/images/logos/Facebook.png"),
                              SizedBox(width: screenWidth * 0.04),
                              const IconContainer(
                                  source: "assets/images/logos/Apple.png"),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          const Center(child: Text("or")),
                          SizedBox(height: screenHeight * 0.02),
                        ],
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Full Name",
                                  style: theme.caption2,
                                ),
                                const SizedBox(height: 4),
                                TextFormField(
                                  // TODO: transfer to components
                                  style: theme.callout,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 10,
                                    ),
                                    prefixIcon: const Icon(Icons.person),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade300,
                                            width: 1)),
                                    focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: theme.primary, width: 1)),
                                  ),
                                  obscureText: false,
                                  validator: (val) => val!.isEmpty
                                      ? "Please enter your name"
                                      : null,
                                  onChanged: (val) {
                                    setState(() => name = val);
                                  },
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Email",
                                  style: theme.caption2,
                                ),
                                const SizedBox(height: 4),
                                TextFormField(
                                  // TODO: transfer to components
                                  style: theme.callout,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 10,
                                    ),
                                    prefixIcon: const Icon(Icons.email),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade300,
                                            width: 1)),
                                    focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: theme.primary, width: 1)),
                                  ),
                                  obscureText: false,
                                  validator: (val) => val!.isEmpty
                                      ? "Please enter your email address"
                                      : null,
                                  onChanged: (val) {
                                    setState(() => email = val);
                                  },
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Password",
                                  style: theme.caption2,
                                ),
                                const SizedBox(height: 4),
                                TextFormField(
                                  // TODO: transfer to components
                                  style: theme.callout,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 10,
                                    ),
                                    prefixIcon:
                                        const Icon(Icons.lock_outline_sharp),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade300,
                                            width: 1)),
                                    focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: theme.primary, width: 1)),
                                  ),
                                  obscureText: true,
                                  validator: (val) => val!.isEmpty
                                      ? "Please enter your password"
                                      : null,
                                  onChanged: (val) {
                                    setState(() => password = val);
                                  },
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Confirm Password",
                                  style: theme.caption2,
                                ),
                                const SizedBox(height: 4),
                                TextFormField(
                                  // TODO: transfer to components
                                  style: theme.callout,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 10,
                                    ),
                                    prefixIcon:
                                        const Icon(Icons.lock_outline_sharp),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade300,
                                            width: 1)),
                                    focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: theme.primary, width: 1)),
                                  ),
                                  obscureText: true,
                                  validator: (val) => val!.isEmpty
                                      ? "Please enter your password"
                                      : null,
                                  onChanged: (val) {
                                    setState(() => confirmPassword = val);
                                  },
                                ),
                              ],
                            ),
                            // InTextFormField(
                            //   icon: const Icon(Icons.person),
                            //   label: "Full Name",
                            //   value: name,
                            // ),
                            // SizedBox(height: screenHeight * 0.02),
                            // InTextFormField(
                            //   icon: const Icon(Icons.email),
                            //   label: "Email",
                            //   value: email,
                            // ),
                            // SizedBox(height: screenHeight * 0.02),
                            // InTextFormField(
                            //   icon: const Icon(Icons.lock_open_sharp),
                            //   label: "Password",
                            //   value: password,
                            //   isObscure: true,
                            // ),
                            // SizedBox(height: screenHeight * 0.02),
                            // InTextFormField(
                            //   icon: const Icon(Icons.lock_open_sharp),
                            //   label: "Confrim Password",
                            //   value: confirmPassword,
                            //   isObscure: true,
                            // ),
                            // SizedBox(height: screenHeight * 0.02),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.025),
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
