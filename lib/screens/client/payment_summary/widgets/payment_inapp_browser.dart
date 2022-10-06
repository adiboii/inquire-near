import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class PaymentInAppBrowser extends InAppBrowser {
  Function setPaymentResponse;

  PaymentInAppBrowser({required this.setPaymentResponse});

  @override
  Future onBrowserCreated() async {}

  @override
  Future onLoadStart(url) async {
    if (url != null && url.toString().contains("localhost")) {
      try {
        setPaymentResponse(
            url.queryParameters["paymentId"], url.queryParameters["PayerID"]);
      } catch (e) {
        log("Set Payment Response Error: ${e.toString()}");
        setPaymentResponse(null, null);
      }

      super.close();
    }
  }

  @override
  Future onLoadStop(url) async {}

  @override
  void onLoadError(url, code, message) {}

  @override
  void onProgressChanged(progress) {}

  @override
  void onExit() {}
}
