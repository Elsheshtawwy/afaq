class ReviewModel {
  final String id;
  final String userId;
  final String courseId;
  final String content;
  final double rating;
  final DateTime createdAt;

  ReviewModel({
    required this.id,
    required this.userId,
    required this.courseId,
    required this.content,
    required this.rating,
    required this.createdAt,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'],
      userId: json['userId'],
      courseId: json['courseId'],
      content: json['content'],
      rating: json['rating'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'courseId': courseId,
      'content': content,
      'rating': rating,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}