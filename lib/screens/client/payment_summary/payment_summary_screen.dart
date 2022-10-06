// Flutter imports:
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:inquire_near/bloc/bloc/payment/payment_bloc.dart';

// Project imports:
import 'package:inquire_near/components/buttons.dart';
import 'package:inquire_near/screens/client/payment_summary/widgets/location.dart';
import 'package:inquire_near/screens/client/payment_summary/widgets/order_summary.dart';
import 'package:inquire_near/screens/client/payment_summary/widgets/payment_inapp_browser.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

import 'package:dio/dio.dart';

import 'package:inquire_near/constants.dart' as constants;

class PaymentSummaryScreen extends StatelessWidget {
  const PaymentSummaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: Padding(
          padding: const EdgeInsets.only(top: 25),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        elevation: 0,
        title: const Padding(
          padding: EdgeInsets.only(top: 25),
          child: Text(
            "Payment Summary",
            style: theme.headline,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<PaymentBloc, PaymentState>(
        listener: (context, state) {
          if (state is PaymentSuccessful) {
            
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content:
                    Text("Payment successful. Redirecting to Answer Page.")));
            // TODO: Redirect to answer screen after payment successful
          }

          if (state is PaymentError) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content:
                    Text("Payment failed. Try again.")));
          }
        },
        builder: (context, state) {
          if (state is Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Padding(
            padding: theme.kScreenPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      Location(
                          screenWidth: screenWidth, screenHeight: screenHeight),
                      SizedBox(height: screenHeight * 0.05),
                      OrderSummary(
                          screenWidth: screenWidth, screenHeight: screenHeight),
                    ],
                  ),
                ),
                ButtonFill(
                    label: "Continue",
                    style: theme.caption1Bold,
                    onTap: () => BlocProvider.of<PaymentBloc>(context)
                        .add(const Pay(100, 'abc123'))),
              ],
            ),
          );
        },
      ),
    );
  }
}
