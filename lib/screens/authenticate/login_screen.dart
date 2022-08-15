import 'package:flutter/material.dart';
import 'package:inquire_near/components/buttons.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

import '../../components/textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = "";
  String password = "";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: theme.kScreenPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Sign in to your account",
                  style: theme.title3,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30),
                      InTextFormField(
                        icon: Icon(Icons.email),
                        label: "Email",
                        value: email,
                      ),
                      SizedBox(height: 15),
                      InTextFormField(
                        icon: Icon(Icons.lock_open_sharp),
                        label: "Password",
                        value: password,
                        isObscure: true,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50),
                ButtonFill(
                  label: "Sign In",
                  onTap: () {
                    Navigator.pushNamed(context, '/client_dashboard');
                  },
                ),
                SizedBox(height: 60),
                Column(
                  children: [
                    SizedBox(height: 10),
                    Center(
                      child: Text(
                        "Sign In With",
                        style:
                            theme.subhead.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                            width: 50,
                            image:
                                AssetImage("assets/images/logos/Google.png")),
                        SizedBox(width: 40),
                        Image(
                            width: 45,
                            image:
                                AssetImage("assets/images/logos/Facebook.png")),
                        SizedBox(width: 40),
                        Image(
                            width: 45,
                            image: AssetImage("assets/images/logos/Apple.png")),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
