import 'package:afaq/models/CourseModel.dart';
import 'package:afaq/models/InstructorModel.dart';

class InstituteModel {
  final String id;
  final String name;
  final String address;
  final List<String> contactNumbers;
  final String? email;
  final String? logoUrl;
  final String? accreditation;
  final String? bio;
  final List<CourseModel>? courses;

  InstituteModel({
    required this.id,
    required this.name,
    required this.address,
    required this.contactNumbers,
    this.email,
    this.logoUrl,
    this.accreditation,
    this.bio,
    this.courses,
  });

  factory InstituteModel.fromJson(Map<String, dynamic> json) {
    return InstituteModel(
      id: json['id'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      contactNumbers: List<String>.from(json['contactNumbers'] ?? []),
      email: json['email'] as String?,
      logoUrl: json['logoUrl'] as String?,
      accreditation: json['accreditation'] as String?,
      bio: json['bio'] as String?,
      courses: (json['courses'] as List<dynamic>?)
          ?.map((c) => CourseModel.fromJson(c as Map<String, dynamic>))
          .toList(),
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
      'accreditation': accreditation,
      'bio': bio,
      'courses': courses?.map((c) => c.toJson()).toList(),
    };
  }
}
