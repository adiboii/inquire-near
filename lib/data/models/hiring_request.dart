// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';

// Project imports:
import 'package:inquire_near/enums/hiring_request_status.dart';

class HiringRequest {
  late String? id;
  final String transactionId;
  final String clientId;
  final String inquirerId;
  final HiringRequestStatus status;
  Timestamp requestMade = Timestamp.now();

  HiringRequest({
    required this.transactionId,
    required this.clientId,
    required this.inquirerId,
    required this.status,
  });

  HiringRequest.fromJson(Map<String, dynamic> json)
      : transactionId = json["transactionId"],
        clientId = json["clientId"],
        inquirerId = json["inquirerId"],
        status = getHiringRequestStatusFromString(json["status"]),
        requestMade = json["requestMade"];

  Map<String, dynamic> toJson() => {
        'transactionId': transactionId,
        'clientId': clientId,
        'inquirerId': inquirerId,
        'status': status.toValue(),
        'requestMade': requestMade
      };

  void setId(String id) {
    this.id = id;
  }
}
