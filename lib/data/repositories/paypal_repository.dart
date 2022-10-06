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

  Future<String?> getPaymentLink() async {
    Response response = await dio.post("${constants.PAYPAL_BASE_URL}/pay",
        data: {"amount": 100, "transactionId": "abc123"});

    List<Map<String, dynamic>> links =
        (response.data as List).map((e) => e as Map<String, dynamic>).toList();

    String? approvalLink = _getApprovalLink(links);

    return approvalLink;
  }
}
