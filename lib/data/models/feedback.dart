class Feedback {
  // Constructors
  Feedback({
    required this.clientEmail,
    required this.inquirerEmail,
    required this.rating,
    this.review = '',
  });

  final String clientEmail;
  final String inquirerEmail;
  final int rating;
  final String? review;

  Map<String, dynamic> toJSON() => {
        'clientEmail': clientEmail,
        'inquirerEmail': inquirerEmail,
        'rating': rating,
        'review': review,
      };
}
