import 'package:cloud_firestore/cloud_firestore.dart';

class HiringRequest {
  final String transactionId;
  final String clientId;
  final String inquirerId;
  final bool isAccepted;
  final Timestamp requestMade = Timestamp.now();

  HiringRequest({
    required this.transactionId,
    required this.clientId,
    required this.inquirerId,
    required this.isAccepted,
  });

  Map<String, dynamic> toJson() => {
        'transactionId': transactionId,
        'clientId': clientId,
        'inquirerId': inquirerId,
        'isAccepted': isAccepted,
        'requestMade': requestMade
      };
}
