import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:inquire_near/data/repositories/paypal_repository.dart';
import 'package:inquire_near/screens/client/payment_summary/widgets/payment_inapp_browser.dart';

import 'package:inquire_near/constants.dart' as constants;

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PayPalRepository payPalRepository;
  

  

  PaymentBloc({required this.payPalRepository}) : super(PaymentInitial()) {
    on<Pay>(_onPay);
  }

  void _onPay(event, emit) async {
    // There may be a lag in the PayPal server. So we emit a loading state here.
    emit(Loading());
    String? approvalLink = await payPalRepository.getPaymentLink();
    emit(PaymentInitial());

    if (approvalLink != null) {
      final PaymentInAppBrowser browser = PaymentInAppBrowser();
      InAppBrowserClassOptions browserOptions = InAppBrowserClassOptions(
          crossPlatform:
              InAppBrowserOptions(hideUrlBar: true, hideToolbarTop: true),
          inAppWebViewGroupOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(javaScriptEnabled: true)));

      browser.openUrlRequest(
          urlRequest: URLRequest(url: Uri.parse(approvalLink)),
          options: browserOptions);
    }
  }
}
