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
  final String? mainImage; 
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
  final List<String>? instructorIds;
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
    this.mainImage, // Added field
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
    this.instructorIds,
    this.address,
    this.numberOfRatings, // Added field
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
      mainImage: json['mainImage'] as String?, // Added field
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
      instructorIds: (json['instructorIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      address: json['address'] as String?,
      numberOfRatings: json['numberOfRatings'] as int?, // Added field
    );
  }

  factory CourseModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CourseModel.fromJson(data);
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
      'mainImage': mainImage, // Added field
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
      'instructorIds': instructorIds,
      'address': address,
      'numberOfRatings': numberOfRatings, // Added field
    };
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
    String? mainImage, // Added field
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
    List<String>? instructorIds,
    String? address,
    int? numberOfRatings, // Added field
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
      mainImage: mainImage ?? this.mainImage, // Added field
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
      instructorIds: instructorIds ?? this.instructorIds,
      address: address ?? this.address,
      numberOfRatings: numberOfRatings ?? this.numberOfRatings, 
    );
  }
}
