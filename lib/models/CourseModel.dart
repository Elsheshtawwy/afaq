class CourseModel {
  final String id;
  final String? title;
  final String? description;
  final String? instructor;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? category;
  final String? subtitle;
  final double? price;
  final double? oldPrice;
  final double? rating;
  final int? students;
  final List<String>? imageUrl;
  final int? reviews;
  final int? classes;
  final int? hours;
  final String? about;
  final String? instructorName;
  final String? instructorImage;
  final List<String>? features;
  final List<Map<String, String>>? reviewsList;
  final List<String>? objectives;
  final List<String>? requirements;
  final List<String>? lessons;
  final int? currentStudents;
  final int? targetStudents;

  CourseModel({
    required this.id,
    this.title,
    this.description,
    this.instructor,
    this.startDate,
    this.endDate,
    this.category,
    this.subtitle,
    this.price,
    this.oldPrice,
    this.rating,
    this.students,
    this.imageUrl,
    this.reviews,
    this.classes,
    this.hours,
    this.about,
    this.instructorName,
    this.instructorImage,
    this.features,
    this.reviewsList,
    this.objectives,
    this.requirements,
    this.lessons,
    this.currentStudents,
    this.targetStudents,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'] as String,
      title: json['title'] as String?,
      description: json['description'] as String?,
      instructor: json['instructor'] as String?,
      startDate: json['startDate'] != null ? DateTime.parse(json['startDate'] as String) : null,
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate'] as String) : null,
      category: json['category'] as String?,
      subtitle: json['subtitle'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      oldPrice: (json['oldPrice'] as num?)?.toDouble(),
      rating: (json['rating'] as num?)?.toDouble(),
      students: json['students'] as int?,
      imageUrl: (json['imageUrl'] as List<dynamic>?)?.map((e) => e as String).toList(),
      reviews: json['reviews'] as int?,
      classes: json['classes'] as int?,
      hours: json['hours'] as int?,
      about: json['about'] as String?,
      instructorName: json['instructorName'] as String?,
      instructorImage: json['instructorImage'] as String?,
      features: (json['features'] as List<dynamic>?)?.map((e) => e as String).toList(),
      reviewsList: (json['reviewsList'] as List<dynamic>?)
          ?.map((e) => Map<String, String>.from(e as Map))
          .toList(),
      objectives: (json['objectives'] as List<dynamic>?)?.map((e) => e as String).toList(),
      requirements: (json['requirements'] as List<dynamic>?)?.map((e) => e as String).toList(),
      lessons: (json['lessons'] as List<dynamic>?)?.map((e) => e as String).toList(),
      currentStudents: json['currentStudents'] as int?,
      targetStudents: json['targetStudents'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'instructor': instructor,
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
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
      'currentStudents': currentStudents,
      'targetStudents': targetStudents,
    };
  }

  CourseModel copyWith({
    String? id,
    String? title,
    String? description,
    String? instructor,
    DateTime? startDate,
    DateTime? endDate,
    String? category,
    String? subtitle,
    double? price,
    double? oldPrice,
    double? rating,
    int? students,
    List<String>? imageUrl,
    int? reviews,
    int? classes,
    int? hours,
    String? about,
    String? instructorName,
    String? instructorImage,
    List<String>? features,
    List<Map<String, String>>? reviewsList,
    List<String>? objectives,
    List<String>? requirements,
    List<String>? lessons,
    int? currentStudents,
    int? targetStudents,
  }) {
    return CourseModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      instructor: instructor ?? this.instructor,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      category: category ?? this.category,
      subtitle: subtitle ?? this.subtitle,
      price: price ?? this.price,
      oldPrice: oldPrice ?? this.oldPrice,
      rating: rating ?? this.rating,
      students: students ?? this.students,
      imageUrl: imageUrl ?? this.imageUrl,
      reviews: reviews ?? this.reviews,
      classes: classes ?? this.classes,
      hours: hours ?? this.hours,
      about: about ?? this.about,
      instructorName: instructorName ?? this.instructorName,
      instructorImage: instructorImage ?? this.instructorImage,
      features: features ?? this.features,
      reviewsList: reviewsList ?? this.reviewsList,
      objectives: objectives ?? this.objectives,
      requirements: requirements ?? this.requirements,
      lessons: lessons ?? this.lessons,
      currentStudents: currentStudents ?? this.currentStudents,
      targetStudents: targetStudents ?? this.targetStudents,
    );
  }
}
