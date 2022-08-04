import 'package:flutter/material.dart';
import 'package:inquire_near/components/buttons.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

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
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          padding: EdgeInsets.fromLTRB(30, 80, 30, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      "Sign in to your account",
                      style: theme.header1,
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      // TODO: transfer to components
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          hintText: "Email",
                          fillColor: Colors.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey.shade300, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: theme.primary, width: 1),
                          )),
                      validator: (val) =>
                          val!.isEmpty ? "Please enter your username" : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        hintText: "Password",
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey.shade300, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: theme.primary, width: 1),
                        ),
                      ),
                      obscureText: true,
                      validator: (val) =>
                          val!.isEmpty ? "Please enter your password" : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
              ButtonFill(
                label: "Sign In",
                onTap: () {
                  Navigator.pushNamed(context, '/user_wallet');
                },
              ),
              SizedBox(height: 60),
              Column(
                children: [
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      "Sign In With",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                          width: 50,
                          image: AssetImage("assets/images/logos/Google.png")),
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
    );
  }
}
