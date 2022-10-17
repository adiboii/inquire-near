class Feedback {
  // Constructors
  Feedback({
    required this.clientID,
    required this.inquirerID,
    required this.rating,
    required this.transactionId,
    this.review = '',
    
  });

  Feedback.fromJson(Map<String, dynamic> json)
      : clientID = json["clientId"],
        inquirerID = json["inquirerId"],
        rating = json["rating"],
        review = json["review"],
        transactionId = json["transactionId"];

  final String transactionId;
  final String clientID;
  final String inquirerID;
  final int rating;
  final String? review;



  Map<String, dynamic> toJSON() => {
        'clientEmail': clientID,
        'inquirerEmail': inquirerID,
        'rating': rating,
        'review': review,
      };
}
