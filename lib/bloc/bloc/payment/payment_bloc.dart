// Dart imports:
import 'dart:async';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// Project imports:
import 'package:inquire_near/collections.dart';
import 'package:inquire_near/data/repositories/paypal_repository.dart';
import 'package:inquire_near/screens/client/payment_summary/widgets/payment_inapp_browser.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PayPalRepository payPalRepository;
  String? payerId;
  String? paymentId;
  bool? isPaying;
  late PaymentInAppBrowser browser;

  PaymentBloc({required this.payPalRepository}) : super(PaymentInitial()) {
    on<Pay>(_onPay);
    on<Payout>(_onPayout);
  }

  // Event handlers
  void _onPay(event, emit) async {
    __setPaymentResponse(null, null);

    emit(Loading());
    String? approvalLink = await payPalRepository.getPaymentLink(
        event.amount, event.transactionId);
    emit(PaymentInitial());

    if (approvalLink != null) {
      browser = PaymentInAppBrowser(setPaymentResponse: __setPaymentResponse);
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
      Timer.periodic(const Duration(seconds: 2), (timer) async {
        if (state.retries >= 5) {
          emit(PaymentInitial());
          timer.cancel();
        }
        if (!isPaying!) {
          if (payerId == null ||
              paymentId == null ||
              payerId == "" ||
              paymentId == "") {
            emit(Loading());
            emit(PaymentError());
          } else {
            emit(Loading());
            bool executeStatus = await payPalRepository.executePayment(
                payerId.toString(), paymentId.toString());

            if (executeStatus) {
              Map<String, dynamic>? paypalTransactionResults =
                  await payPalRepository.getPaymentDetails(paymentId!);
              if (paypalTransactionResults == null) {
                emit(Loading());
                emit(PaymentError());
              } else {
                FirebaseFirestore.instance
                    .collection(transactionCollection)
                    .doc(event.transactionId)
                    .update({
                  'payPalId': paypalTransactionResults["id"],
                  'payPalStatus': paypalTransactionResults["state"]
                });
                emit(Loading());
                emit(PaymentSuccessful());
              }
            } else {
              emit(Loading());
              emit(PaymentError());
            }
          }
          timer.cancel();
        }
      });

      await completer.future;
    }

    emit(PaymentInitial());
  }

  void _onPayout(Payout event, emit) async {
    bool payoutStatus = await payPalRepository.payout(
        clientName: event.clientName,
        transactionId: event.transactionId,
        inquirerPayPalEmail: event.inquirerPayPalEmail,
        amount: event.amount);

    if (payoutStatus) {
      emit(PayoutSuccessful());
    } else {
      emit(PayoutFailed());
    }
  }

  // Helper functions
  void __setPaymentResponse(String? payerId, String? paymentId) {
    this.payerId = payerId;
    this.paymentId = paymentId;
    isPaying = false;
  }
}
