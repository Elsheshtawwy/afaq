import 'package:afaq/models/InstructorModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CourseModel {
  final String id;
  final String? title;
  final String? description;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? category;
  final String? subtitle;
  final double? price;
  final double? oldPrice;
  final double? rating;
  final List<String>? imageUrl;
  final int? reviews;
  final int? classes;
  final int? hours;
  final String? about;
  final List<String>? features;
  final List<Map<String, String>>? reviewsList;
  final List<String>? objectives;
  final List<String>? requirements;
  final List<String>? lessons;
  final int? currentStudents;
  final int? targetStudents;
  final String? level;
  final bool? isOnline;
  final List<InstructorModel>? instructors;
  final String? address;
  final int? numberOfRatings;

  CourseModel({
    required this.id,
    this.title,
    this.description,
    this.startDate,
    this.endDate,
    this.category,
    this.subtitle,
    this.price,
    this.oldPrice,
    this.rating,
    this.imageUrl,
    this.reviews,
    this.classes,
    this.hours,
    this.about,
    this.features,
    this.reviewsList,
    this.objectives,
    this.requirements,
    this.lessons,
    this.currentStudents,
    this.targetStudents,
    this.level,
    this.isOnline,
    this.instructors,
    this.address,
    this.numberOfRatings,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String?,
      description: json['description'] as String?,
      startDate: json['startDate'] != null
          ? DateTime.parse(json['startDate'] as String)
          : null,
      endDate: json['endDate'] != null
          ? DateTime.parse(json['endDate'] as String)
          : null,
      category: json['category'] as String?,
      subtitle: json['subtitle'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      oldPrice: (json['oldPrice'] as num?)?.toDouble(),
      rating: (json['rating'] as num?)?.toDouble(),
      imageUrl: json['imageUrl'] is String
          ? [json['imageUrl'] as String]
          : (json['imageUrl'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      reviews: json['reviews'] as int?,
      classes: json['classes'] as int?,
      hours: json['hours'] as int?,
      about: json['about'] as String?,
      features: (json['features'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      reviewsList: (json['reviewsList'] as List<dynamic>?)
          ?.map((e) => Map<String, String>.from(e as Map))
          .toList(),
      objectives: (json['objectives'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      requirements: (json['requirements'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      lessons:
          (json['lessons'] as List<dynamic>?)?.map((e) => e as String).toList(),
      currentStudents: json['currentStudents'] as int?,
      targetStudents: json['targetStudents'] as int?,
      level: json['level'] as String?,
      isOnline: json['isOnline'] as bool?,
      instructors: (json['instructors'] as List<dynamic>?)
          ?.map((e) => InstructorModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      address: json['address'] as String?,
      numberOfRatings: json['numberOfRatings'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'category': category,
      'subtitle': subtitle,
      'price': price,
      'oldPrice': oldPrice,
      'rating': rating,
      'imageUrl': imageUrl,
      'reviews': reviews,
      'classes': classes,
      'hours': hours,
      'about': about,
      'features': features,
      'reviewsList': reviewsList,
      'objectives': objectives,
      'requirements': requirements,
      'lessons': lessons,
      'currentStudents': currentStudents,
      'targetStudents': targetStudents,
      'level': level,
      'isOnline': isOnline,
      'instructors': instructors?.map((e) => e.toJson()).toList(),
      'address': address,
      'numberOfRatings': numberOfRatings,
    };
  }

  factory CourseModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CourseModel.fromJson(data);
  }

  Map<String, dynamic> toFirestore() {
    return toJson();
  }

  CourseModel copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    String? category,
    String? subtitle,
    double? price,
    double? oldPrice,
    double? rating,
    List<String>? imageUrl,
    int? reviews,
    int? classes,
    int? hours,
    String? about,
    List<String>? features,
    List<Map<String, String>>? reviewsList,
    List<String>? objectives,
    List<String>? requirements,
    List<String>? lessons,
    int? currentStudents,
    int? targetStudents,
    String? level,
    bool? isOnline,
    List<InstructorModel>? instructors,
    String? address,
    int? numberOfRatings,
  }) {
    return CourseModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      category: category ?? this.category,
      subtitle: subtitle ?? this.subtitle,
      price: price ?? this.price,
      oldPrice: oldPrice ?? this.oldPrice,
      rating: rating ?? this.rating,
      imageUrl: imageUrl ?? this.imageUrl,
      reviews: reviews ?? this.reviews,
      classes: classes ?? this.classes,
      hours: hours ?? this.hours,
      about: about ?? this.about,
      features: features ?? this.features,
      reviewsList: reviewsList ?? this.reviewsList,
      objectives: objectives ?? this.objectives,
      requirements: requirements ?? this.requirements,
      lessons: lessons ?? this.lessons,
      currentStudents: currentStudents ?? this.currentStudents,
      targetStudents: targetStudents ?? this.targetStudents,
      level: level ?? this.level,
      isOnline: isOnline ?? this.isOnline,
      instructors: instructors ?? this.instructors,
      address: address ?? this.address,
      numberOfRatings: numberOfRatings ?? this.numberOfRatings,
    );
  }

  CourseModel fromMap(Map<String, dynamic> map) {
    return CourseModel(
      id: map['id'] as String? ?? '',
      title: map['title'] as String?,
      description: map['description'] as String?,
      startDate: map['startDate'] != null
          ? DateTime.parse(map['startDate'] as String)
          : null,
      endDate: map['endDate'] != null
          ? DateTime.parse(map['endDate'] as String)
          : null,
      category: map['category'] as String?,
      subtitle: map['subtitle'] as String?,
      price: (map['price'] as num?)?.toDouble(),
      oldPrice: (map['oldPrice'] as num?)?.toDouble(),
      rating: (map['rating'] as num?)?.toDouble(),
      imageUrl: map['imageUrl'] is String
          ? [map['imageUrl'] as String]
          : (map['imageUrl'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      reviews: map['reviews'] as int?,
      classes: map['classes'] as int?,
      hours: map['hours'] as int?,
      about: map['about'] as String?,
      features:
          (map['features'] as List<dynamic>?)?.map((e) => e as String).toList(),
      reviewsList: (map['reviewsList'] as List<dynamic>?)
          ?.map((e) => Map<String, String>.from(e as Map))
          .toList(),
      objectives: (map['objectives'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      requirements: (map['requirements'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      lessons:
          (map['lessons'] as List<dynamic>?)?.map((e) => e as String).toList(),
      currentStudents: map['currentStudents'] as int?,
      targetStudents: map['targetStudents'] as int?,
      level: map['level'] as String?,
      isOnline: map['isOnline'] as bool?,
      address: map['address'] as String?,
      numberOfRatings: map['numberOfRatings'] as int?,
    );
  }
}
