class CourseModel {
  final String id;
  final String title;
  final String description;
  final String instructor;
  final DateTime startDate;
  final DateTime endDate;
  final String category;
  final String subtitle;
  final double price;
  final double oldPrice;
  final double rating;
  final int students;
  final String imageUrl;
  final int reviews;
  final int classes;
  final int hours;
  final String about;
  final String instructorName;
  final String instructorImage;
  final List<String> features;
  final List<Map<String, String>> reviewsList;
  final List<String> objectives;
  final List<String> requirements;
  final List<String> lessons;

  CourseModel({
    required this.id,
    required this.title,
    required this.description,
    required this.instructor,
    required this.startDate,
    required this.endDate,
    required this.category,
    required this.subtitle,
    required this.price,
    required this.oldPrice,
    required this.rating,
    required this.students,
    required this.imageUrl,
    required this.reviews,
    required this.classes,
    required this.hours,
    required this.about,
    required this.instructorName,
    required this.instructorImage,
    required this.features,
    required this.reviewsList,
    required this.objectives,
    required this.requirements,
    required this.lessons,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      instructor: json['instructor'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      category: json['category'],
      subtitle: json['subtitle'],
      price: json['price'].toDouble(),
      oldPrice: json['oldPrice'].toDouble(),
      rating: json['rating'].toDouble(),
      students: json['students'],
      imageUrl: json['imageUrl'],
      reviews: json['reviews'],
      classes: json['classes'],
      hours: json['hours'],
      about: json['about'],
      instructorName: json['instructorName'],
      instructorImage: json['instructorImage'],
      features: List<String>.from(json['features']),
      reviewsList: List<Map<String, String>>.from(json['reviewsList'].map((review) => Map<String, String>.from(review))),
      objectives: List<String>.from(json['objectives']),
      requirements: List<String>.from(json['requirements']),
      lessons: List<String>.from(json['lessons']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'instructor': instructor,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'category': category,
      'subtitle': subtitle,
      'price': price,
      'oldPrice': oldPrice,
      'rating': rating,
      'students': students,
      'imageUrl': imageUrl,
      'reviews': reviews,
      'classes': classes,
      'hours': hours,
      'about': about,
      'instructorName': instructorName,
      'instructorImage': instructorImage,
      'features': features,
      'reviewsList': reviewsList,
      'objectives': objectives,
      'requirements': requirements,
      'lessons': lessons,
    };
  }
}
