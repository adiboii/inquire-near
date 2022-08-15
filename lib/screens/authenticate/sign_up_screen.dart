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
    final size = MediaQuery.of(context).size;
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
                    Text(
                      "Create a new account",
                      style: theme.title2,
                    ),
                    SizedBox(height: 32),
                    Center(
                      child: Text(
                        "Use your socials",
                        style: theme.subhead,
                      ),
                    ),
                    SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconContainer(source: "assets/images/logos/Google.png"),
                        SizedBox(width: 12),
                        IconContainer(
                            source: "assets/images/logos/Facebook.png"),
                        SizedBox(width: 12),
                        IconContainer(source: "assets/images/logos/Apple.png"),
                      ],
                    ),
                    SizedBox(height: 12),
                    Center(child: Text("or")),
                    SizedBox(height: 12),
                  ],
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      InTextFormField(
                        icon: Icon(Icons.person),
                        label: "Full Name",
                        value: name,
                      ),
                      SizedBox(height: 12),
                      InTextFormField(
                        icon: Icon(Icons.email),
                        label: "Email",
                        value: email,
                      ),
                      SizedBox(height: 12),
                      InTextFormField(
                        icon: Icon(Icons.lock_open_sharp),
                        label: "Password",
                        value: password,
                        isObscure: true,
                      ),
                      SizedBox(height: 12),
                      InTextFormField(
                        icon: Icon(Icons.lock_open_sharp),
                        label: "Confrim Password",
                        value: confirmPassword,
                        isObscure: true,
                      ),
                      SizedBox(height: 12),
                    ],
                  ),
                ),
                SizedBox(height: 16),
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
