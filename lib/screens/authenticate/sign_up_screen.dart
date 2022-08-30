import 'package:flutter/material.dart';
import 'package:inquire_near/components/buttons.dart';
import 'package:inquire_near/components/container.dart';
import 'package:inquire_near/components/textfield.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

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

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
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
                      InTextFormField(
                        icon: const Icon(Icons.person),
                        label: "Full Name",
                        value: name,
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      InTextFormField(
                        icon: const Icon(Icons.email),
                        label: "Email",
                        value: email,
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      InTextFormField(
                        icon: const Icon(Icons.lock_open_sharp),
                        label: "Password",
                        value: password,
                        isObscure: true,
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      InTextFormField(
                        icon: const Icon(Icons.lock_open_sharp),
                        label: "Confrim Password",
                        value: confirmPassword,
                        isObscure: true,
                      ),
                      SizedBox(height: screenHeight * 0.02),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.025),
                ButtonFill(
                  label: "Create Account",
                  onTap: () {
                    Navigator.pushNamed(context, '/client_dashboard');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
