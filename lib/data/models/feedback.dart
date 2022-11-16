class Feedback {
  // Constructors
  Feedback({
    required this.clientId,
    required this.inquirerId,
    required this.rating,
    required this.transactionId,
    this.review = '',
  });

  Feedback.fromJson(Map<String, dynamic> json)
      : clientId = json["clientId"],
        inquirerId = json["inquirerId"],
        rating = json["rating"],
        review = json["review"],
        transactionId = json["transactionId"];

  final String transactionId;
  final String clientId;
  final String inquirerId;
  final int rating;
  final String? review;

  Map<String, dynamic> toJSON() => {
        'clientId': clientId,
        'inquirerId': inquirerId,
        'rating': rating,
        'review': review,
        'transactionId': transactionId,
      };
}
