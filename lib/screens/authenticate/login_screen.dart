// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inquire_near/bloc/bloc/auth_bloc.dart';

// Project imports:
import 'package:inquire_near/components/buttons.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _authenticateWithEmailAndPassword(context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        SignInRequested(email.text, password.text),
      );
    }
  }

  void _authenticateWithGoogle(context) {
    BlocProvider.of<AuthBloc>(context).add(GoogleSignInRequested());
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final double screenWidth = MediaQuery.of(context).size.width;
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
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: screenHeight * 0.03),
                            const Text(
                              "Email",
                              style: theme.caption2,
                            ),
                            const SizedBox(height: 4),
                            TextFormField(
                              // TODO: transfer to components
                              controller: email,
                              style: theme.callout,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 10,
                                ),
                                prefixIcon: const Icon(Icons.email),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade300, width: 1)),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: theme.primary, width: 1)),
                              ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              obscureText: false,
                              validator: (val) => val!.isEmpty
                                  ? "Please enter your email address"
                                  : null,
                            ),
                            SizedBox(height: screenHeight * 0.04),
                            const Text(
                              "Password",
                              style: theme.caption2,
                            ),
                            const SizedBox(height: 4),
                            TextFormField(
                              // TODO: transfer to components
                              controller: password,
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
                                        color: Colors.grey.shade300, width: 1)),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: theme.primary, width: 1)),
                              ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              obscureText: true,
                              validator: (val) => val!.isEmpty
                                  ? "Please enter your password"
                                  : null,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.07),
                      ButtonFill(
                        label: "Sign In",
                        onTap: () {
                          _authenticateWithEmailAndPassword(context);
                        },
                      ),
                      SizedBox(height: screenHeight * 0.075),
                      Center(
                        child: Text(
                          "Sign In With",
                          style: theme.subhead
                              .copyWith(fontWeight: FontWeight.bold),
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
