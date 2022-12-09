// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:inquire_near/bloc/bloc/auth/auth_bloc.dart';
import 'package:inquire_near/components/buttons.dart';
import 'package:inquire_near/components/input_field.dart';
import 'package:inquire_near/components/input_validator.dart';
import 'package:inquire_near/routes.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

class PaypalAccountScreen extends StatelessWidget {
  PaypalAccountScreen({super.key});
  final emailAddressTextController = TextEditingController();
  final inputValidator = InputValidator();
  final _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Future<void> storePaypalAddress() async {
      if (_globalKey.currentState!.validate()) {
        BlocProvider.of<AuthBloc>(context).add(
          StorePaypalAddressRequested(emailAddressTextController.text),
        );
      }
    }

    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is PaypalAddressStored) {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(wrapperRoute, (route) => false);
            }

            if (state is Unauthenticated) {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(landingRoute, (route) => false);
            }
          },
          child: Padding(
            padding: theme.kScreenPadding,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/logos/paypal.png',
                    height: screenHeight * 0.18,
                  ),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  const Text(
                    'Connect your\n PayPal Account',
                    style: theme.title3,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  const Text(
                    'Please enter your PayPal email address',
                    style: theme.caption2,
                  ),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  Form(
                    key: _globalKey,
                    child: InputField(
                      label: 'Email Address',
                      controller: emailAddressTextController,
                      icon: Icons.email,
                      validator: (string) {
                        if (!inputValidator.isEmpty(string)) {
                          if (!inputValidator.isValidEmailAddress(string)) {
                            return 'Invalid Email Address format';
                          }
                        } else {
                          return 'Please enter your email address';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.04,
                  ),
                  ButtonFill(
                    label: 'Connect',
                    onTap: storePaypalAddress,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  GestureDetector(
                    onTap: () {
                      BlocProvider.of<AuthBloc>(context)
                          .add(SignOutRequested());
                    },
                    child: const Text("Sign Out"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
