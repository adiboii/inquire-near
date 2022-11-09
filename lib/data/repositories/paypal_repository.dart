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
    Response response = await dio.post("${constants.PayPalBaseURL}/pay",
        data: {"amount": amount, "transactionId": transactionId});

    List<Map<String, dynamic>> links =
        (response.data as List).map((e) => e as Map<String, dynamic>).toList();

    String? approvalLink = _getApprovalLink(links);

    return approvalLink;
  }

  Future<bool> executePayment(String payerId, String paymentId) async {
    try {
      Response response = await dio.get(
          "${constants.PayPalBaseURL}/success?PayerID=$payerId&paymentId=$paymentId");

      log("${constants.PayPalBaseURL}/success?PayerID=$payerId&paymentId=$paymentId");
      log(response.data);
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      log("executePayment Error: $e");
    }

    return false;
  }

  Future<Map<String, dynamic>?> getPaymentDetails(String paymentId) async {
    try {
      Response response =
          await dio.get("${constants.PayPalBaseURL}/transaction-details?paymentId=$paymentId");

      return response.data["transactions"][0]["related_resources"][0]["sale"];
    } catch (e) {
      log("executePayment Error: $e");
    }

    return null;
  }
}
