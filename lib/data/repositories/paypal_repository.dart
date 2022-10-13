// Dart imports:
import 'dart:developer';

// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:inquire_near/constants.dart' as constants;

class PayPalRepository {
  Dio dio = Dio();

  String? _getApprovalLink(List<Map<String, dynamic>> links) {
    for (Map<String, dynamic> linkData in links) {
      if (linkData["name"] == "approval_url") {
        return linkData["link"];
      }
    }
    return null;
  }

  Future<String?> getPaymentLink(double amount, String transactionId) async {
    Response response = await dio.post("${constants.PAYPAL_BASE_URL}/pay",
        data: {"amount": amount, "transactionId": transactionId});

    List<Map<String, dynamic>> links =
        (response.data as List).map((e) => e as Map<String, dynamic>).toList();

    String? approvalLink = _getApprovalLink(links);

    return approvalLink;
  }

  Future<bool> executePayment(String payerId, String paymentId) async {
    try {
      Response response = await dio.get(
          "${constants.PAYPAL_BASE_URL}/success?PayerID=$payerId&paymentId=$paymentId");
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      log("executePayment Error: $e");
    }

    return false;
  }
}
