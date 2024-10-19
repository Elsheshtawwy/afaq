import 'package:afaq/models/InstructorModel.dart';
import 'package:afaq/models/CourseModel.dart';

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
  final List<InstructorModel> instructors;
  final List<CourseModel> courses;

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
    required this.instructors,
    required this.courses,
  });

  factory InstituteModel.fromJson(Map<String, dynamic> json) {
    return InstituteModel(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      contactNumbers: List<String>.from(json['contactNumbers']),
      email: json['email'],
      logoUrl: json['logoUrl'],
      rating: json['rating'],
      reviews: List<String>.from(json['reviews'] ?? []),
      accreditation: json['accreditation'],
      instructors: List<InstructorModel>.from(
          json['instructors']?.map((x) => InstructorModel.fromJson(x))),
      courses: List<CourseModel>.from(
          json['courses']?.map((x) => CourseModel.fromJson(x))),
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
      'instructors': instructors.map((x) => x.toJson()).toList(),
      'courses': courses.map((x) => x.toJson()).toList(),
    };
  }
}
