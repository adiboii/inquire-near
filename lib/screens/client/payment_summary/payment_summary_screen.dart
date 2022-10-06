// Flutter imports:
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// Project imports:
import 'package:inquire_near/components/buttons.dart';
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
      body: SafeArea(
        child: Padding(
          padding: theme.kScreenPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(width: screenWidth * 0.02),
                            const Text(
                              'Location',
                              style: theme.subheadBold,
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
                            SizedBox(
                              width: screenWidth * 0.02,
                            ),
                            const Text(
                              'Order',
                              style: theme.subheadBold,
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
                        const Divider(
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
                style: theme.caption1Bold,
                onTap: () async {
                  Dio dio = Dio();

                  Response response = await dio.post(
                      "${constants.PAYPAL_BASE_URL}/pay",
                      data: {"amount": 100, "transactionId": "abc123"});

                  List<Map<String, dynamic>> links = (response.data as List)
                      .map((e) => e as Map<String, dynamic>)
                      .toList();

                  String? getApprovalLink(List<Map<String, dynamic>> links) {
                    for (Map<String, dynamic> linkData in links) {
                      if (linkData["name"] == "approval_url") {
                        return linkData["link"];
                      }
                    }
                    return null;
                  }

                  String? approvalLink = getApprovalLink(links);

                  if (approvalLink != null) {
                    final PaymentInAppBrowser browser = PaymentInAppBrowser();
                    InAppBrowserClassOptions browserOptions =
                        InAppBrowserClassOptions(
                            crossPlatform:
                                InAppBrowserOptions(hideUrlBar: true, hideToolbarTop: true),
                            inAppWebViewGroupOptions: InAppWebViewGroupOptions(
                                crossPlatform: InAppWebViewOptions(
                                    javaScriptEnabled: true)));

                    browser.openUrlRequest(
                        urlRequest: URLRequest(url: Uri.parse(approvalLink)),
                        options: browserOptions);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
