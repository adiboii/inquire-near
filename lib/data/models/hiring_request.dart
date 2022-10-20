// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';

// Project imports:
import 'package:inquire_near/data/models/enums.dart';

class HiringRequest {
  final String transactionId;
  final String clientId;
  final String inquirerId;
  final HiringRequestStatus status;
  final Timestamp requestMade = Timestamp.now();

  HiringRequest({
    required this.transactionId,
    required this.clientId,
    required this.inquirerId,
    required this.status,
  });

  Map<String, dynamic> toJson() => {
        'transactionId': transactionId,
        'clientId': clientId,
        'inquirerId': inquirerId,
        'status': status.toValue(),
        'requestMade': requestMade
      };
}
