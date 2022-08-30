// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
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
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
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
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: screenHeight * 0.03),
                      InTextFormField(
                        icon: const Icon(Icons.email),
                        label: "Email",
                        value: email,
                      ),
                      SizedBox(height: screenHeight * 0.04),
                      InTextFormField(
                        icon: const Icon(Icons.lock_open_sharp),
                        label: "Password",
                        value: password,
                        isObscure: true,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.07),
                ButtonFill(
                  label: "Sign In",
                  onTap: () {
                    Navigator.pushNamed(context, '/client_dashboard');
                  },
                ),
                SizedBox(height: screenHeight * 0.075),
                Column(
                  children: [
                    SizedBox(height: screenHeight * 0.01),
                    Center(
                      child: Text(
                        "Sign In With",
                        style:
                            theme.subhead.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Image(
                            width: 50,
                            image:
                                AssetImage("assets/images/logos/Google.png")),
                        SizedBox(width: screenWidth * 0.10),
                        const Image(
                            width: 45,
                            image:
                                AssetImage("assets/images/logos/Facebook.png")),
                        SizedBox(width: screenWidth * 0.10),
                        const Image(
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
