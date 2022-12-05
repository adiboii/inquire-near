class Feedback {
  // Constructors
  Feedback({
    required this.feedbacker,
    required this.recepient,
    required this.rating,
    required this.transactionId,
    this.review = '',
  });

  Feedback.fromJson(Map<String, dynamic> json)
      : feedbacker = json["feedbackerId"],
        recepient = json["recepientId"],
        rating = json["rating"],
        review = json["review"],
        transactionId = json["transactionId"];

  final String transactionId;
  final String feedbacker;
  final String recepient;
  final int rating;
  final String? review;

  Map<String, dynamic> toJSON() => {
        'feedbackerId': feedbacker,
        'recepientId': recepient,
        'rating': rating,
        'review': review,
        'transactionId': transactionId,
      };
}
