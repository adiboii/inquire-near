import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inquire_near/components/buttons.dart';
import 'package:inquire_near/themes/app_theme.dart' as theme;

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
          padding: EdgeInsets.only(top: 25),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.only(top: 25),
          child: Text(
            "Payment Summary",
            style: theme.headline,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: theme.kScreenPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Pay with",
                          style: theme.headline,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                    "assets/images/logos/paypal.svg"),
                                SizedBox(width: screenWidth * 0.02),
                                Text(
                                  "Paypal",
                                  style: theme.subhead,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Available Balance",
                                  style: theme.caption2
                                      .copyWith(color: theme.primary),
                                ),
                                Text(
                                  "PHP 455.20",
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.05),
                    Column(
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset("assets/images/svgs/location.svg"),
                            SizedBox(width: screenWidth * 0.02),
                            Text(
                              'Location',
                              style: theme.subhead_bold,
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.015),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: screenWidth * 0.071,
                            ),
                            Image.asset(
                              'assets/images/logos/BIR.png',
                              width: screenWidth * 0.1,
                            ),
                            SizedBox(
                              width: screenWidth * 0.03,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Bureau of Internal Revenue (BIR)',
                                  style: theme.caption1,
                                ),
                                Text(
                                  'Cebu South Branch',
                                  style: theme.caption1,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.05),
                    Column(
                      children: [
                        Row(
                          children: [
                            //TODO: change to order svg
                            SvgPicture.asset("assets/images/svgs/location.svg"),
                            SizedBox(
                              width: screenWidth * 0.02,
                            ),
                            Text(
                              'Order',
                              style: theme.subhead_bold,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: screenHeight * 0.015,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Inquiries',
                              style: theme.caption1,
                            ),
                            Text(
                              '4 x PHP 25.00',
                              style: theme.caption1,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Require Proof',
                              style: theme.caption1,
                            ),
                            Text(
                              '4 x PHP 5.00',
                              style: theme.caption1,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        Divider(
                          thickness: 0.9,
                          color: Colors.black,
                        ),
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Total Amount',
                              style: theme.caption1,
                            ),
                            Text(
                              'PHP 100.00',
                              style: theme.headline,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ButtonFill(
                label: "Continue",
                style: theme.caption1_bold,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
