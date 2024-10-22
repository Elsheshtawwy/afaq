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
  final String? bio; 
  final List<String> instructorsID;
  final List<String> coursesID;

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
    required this.instructorsID,
    required this.coursesID,
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
      bio: json['bio'], 
      instructorsID: List<String>.from(json['instructorsID']),
      coursesID: List<String>.from(json['coursesID']),
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
      'instructorsID': instructorsID,
      'coursesID': coursesID,
    };
  }
}
