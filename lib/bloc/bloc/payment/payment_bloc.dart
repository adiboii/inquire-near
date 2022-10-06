import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:inquire_near/data/repositories/paypal_repository.dart';
import 'package:inquire_near/screens/client/payment_summary/widgets/payment_inapp_browser.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PayPalRepository payPalRepository;
  String? payerId;
  String? paymentId;
  bool? isPaying;

  PaymentBloc({required this.payPalRepository}) : super(PaymentInitial()) {
    on<Pay>(_onPay);
  }

  void setPaymentResponse(String? payerId, String? paymentId) {
    this.payerId = payerId;
    this.paymentId = paymentId;
    isPaying = false;
  }

  void _onPay(event, emit) async {
    setPaymentResponse(null, null);

    emit(Loading());
    String? approvalLink = await payPalRepository.getPaymentLink();

    if (approvalLink != null) {
      final PaymentInAppBrowser browser =
          PaymentInAppBrowser(setPaymentResponse: setPaymentResponse);
      InAppBrowserClassOptions browserOptions = InAppBrowserClassOptions(
          crossPlatform:
              InAppBrowserOptions(hideUrlBar: true, hideToolbarTop: true),
          inAppWebViewGroupOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(javaScriptEnabled: true)));

      isPaying = true;
      await browser.openUrlRequest(
          urlRequest: URLRequest(url: Uri.parse(approvalLink)),
          options: browserOptions);

      // Wait for payment details to be set
      final completer = Completer();
      Timer.periodic(const Duration(seconds: 1), (timer) {
        if (!isPaying!) {
          if (payerId == null ||
              paymentId == null ||
              payerId == "" ||
              paymentId == "") {
            emit(PaymentError());
          } else {
            emit(PaymentSuccessful());
          }
          timer.cancel();
        }
      });

      await completer.future;
    }
  }
}
