class Feedback {
  // Constructors
  Feedback({
    required this.clientID,
    required this.inquirerID,
    required this.rating,
    this.review = '',
  });

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
