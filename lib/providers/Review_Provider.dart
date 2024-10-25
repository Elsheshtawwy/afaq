import 'package:afaq/models/ReviewModel.dart';
import 'package:flutter/material.dart';


class ReviewProvider with ChangeNotifier {
  final List<ReviewModel> _reviews = [];

  List<ReviewModel> get reviews => List.unmodifiable(_reviews);

  void addReview({
    required String content,
    required double rating,
    required String userId,
    required String courseId,
    DateTime? createdAt,
  }) {
    final newReview = ReviewModel(
      id: DateTime.now().toString(),
      content: content,
      rating: rating,
      userId: userId,
      courseId: courseId,
      createdAt: createdAt ?? DateTime.now(),
    );
    _reviews.add(newReview);
    notifyListeners();
  }

  void removeReview(String id) {
    _reviews.removeWhere((review) => review.id == id);
    notifyListeners();
  }

  void updateReview({
    required String id,
    required String newContent,
    required double newRating,
  }) {
    final reviewIndex = _reviews.indexWhere((review) => review.id == id);
    if (reviewIndex >= 0) {
      _reviews[reviewIndex] = ReviewModel(
        id: id,
        content: newContent,
        rating: newRating,
        userId: _reviews[reviewIndex].userId,
        courseId: _reviews[reviewIndex].courseId,
        createdAt: _reviews[reviewIndex].createdAt,
      );
      notifyListeners();
    }
  }
}





