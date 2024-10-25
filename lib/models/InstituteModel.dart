import 'package:afaq/models/CourseModel.dart';
import 'package:afaq/models/InstructorModel.dart';

class InstituteModel {
  final String id;
  final String name;
  final String address;
  final List<String> contactNumbers;
  final String? email;
  final String? logoUrl;
  final double? rating;
  final List<String>? reviews;
  final String? accreditation;
  final String? bio;
  final List<InstructorModel>? instructors;
  final List<CourseModel>? courses;
  final List<String>? images; 

  InstituteModel({
    required this.id,
    required this.name,
    required this.address,
    required this.contactNumbers,
    this.email,
    this.logoUrl,
    this.rating,
    this.reviews,
    this.accreditation,
    this.bio,
    this.instructors,
    this.courses,
    this.images, 
  });

  factory InstituteModel.fromJson(Map<String, dynamic> json) {
    return InstituteModel(
      id: json['id'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      contactNumbers: List<String>.from(json['contactNumbers'] ?? []),
      email: json['email'] as String?,
      logoUrl: json['logoUrl'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      reviews: List<String>.from(json['reviews'] ?? []),
      accreditation: json['accreditation'] as String?,
      bio: json['bio'] as String?,
      instructors: (json['instructors'] as List<dynamic>?)
          ?.map((i) => InstructorModel.fromJson(i as Map<String, dynamic>))
          .toList(),
      courses: (json['courses'] as List<dynamic>?)
          ?.map((c) => CourseModel.fromJson(c as Map<String, dynamic>))
          .toList(),
      images: List<String>.from(json['images'] ?? []), 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'contactNumbers': contactNumbers,
      'email': email,
      'logoUrl': logoUrl,
      'rating': rating,
      'reviews': reviews,
      'accreditation': accreditation,
      'bio': bio,
      'instructors': instructors?.map((i) => i.toJson()).toList(),
      'courses': courses?.map((c) => c.toJson()).toList(),
      'images': images, 
    };
  }
}
