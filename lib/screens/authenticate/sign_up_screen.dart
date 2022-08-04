import 'package:flutter/material.dart';
import 'package:inquire_near/components/buttons.dart';
import 'package:inquire_near/components/container.dart';
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
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          padding: EdgeInsets.fromLTRB(30, 50, 30, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Create a new account",
                      style: theme.header1.copyWith(fontSize: 32)),
                  SizedBox(height: 30),
                  Text(
                    "Use your socials",
                    style: theme.header4,
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconContainer(source: "assets/images/logos/Google.png"),
                      SizedBox(width: 10),
                      IconContainer(source: "assets/images/logos/Facebook.png"),
                      SizedBox(width: 10),
                      IconContainer(source: "assets/images/logos/Apple.png"),
                    ],
                  ),
                  SizedBox(height: 10),
                  Center(child: Text("or")),
                  SizedBox(height: 10),
                ],
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          hintText: "Full Name",
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
                      validator: (val) => val!.isEmpty ? "Enter a name" : null,
                      onChanged: (val) {
                        setState(() => name = val);
                      },
                    ),
                    SizedBox(height: 15),
                    TextFormField(
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
                          val!.isEmpty ? "Enter an Email" : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            hintText: "Password",
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
                        obscureText: true,
                        validator: (val) => val!.length <= 6
                            ? "Enter a password with more than 6 characters"
                            : null,
                        onChanged: (val) {
                          setState(() => password = val);
                        }),
                    SizedBox(height: 15),
                    TextFormField(
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            hintText: "Confirm Password",
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
                        obscureText: true,
                        validator: (val) =>
                            val != password ? "Passwords do not match" : null,
                        onChanged: (val) {
                          setState(() => confirmPassword = val);
                        }),
                    SizedBox(height: 15),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ButtonFill(
                label: "Create Account",
                onTap: () {
                  Navigator.pushNamed(context, '/user_wallet');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
