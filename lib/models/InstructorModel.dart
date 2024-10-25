import 'dart:core';

import 'package:afaq/models/InstituteModel.dart';
import 'package:afaq/models/CourseModel.dart'; 

class InstructorModel {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String profilePicture;
  final List<InstituteModel>? institutes;
  final List<CourseModel>? coursesTaught; 
  final List<String>? qualifications;
  final String? bio;
  final int? experienceYears;
  final String? gender;
  final List<String>? experiences;
  final bool? isVerified;
  final String? jobTitle;

  InstructorModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
    this.institutes,
    this.coursesTaught,
    this.qualifications,
    this.bio,
    this.experienceYears,
    this.gender,
    this.experiences,
    this.isVerified,
    this.jobTitle,
  });

  factory InstructorModel.fromJson(Map<String, dynamic> json) {
    return InstructorModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      profilePicture: json['profilePicture'],
      institutes: (json['institutes'] as List)
          .map((i) => InstituteModel.fromJson(i))
          .toList(),
      coursesTaught: (json['coursesTaught'] as List?)
          ?.map((c) => CourseModel.fromJson(c))
          .toList(), 
      qualifications: json['qualifications'] != null ? List<String>.from(json['qualifications']) : null,
      bio: json['bio'],
      experienceYears: json['experienceYears'],
      gender: json['gender'],
      experiences: json['experiences'] != null ? List<String>.from(json['experiences']) : null,
      isVerified: json['isVerified'],
      jobTitle: json['jobTitle'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'profilePicture': profilePicture,
      'institutes': institutes!.map((i) => i.toJson()).toList(),
      'coursesTaught': coursesTaught?.map((c) => c.toJson()).toList(), 
      'qualifications': qualifications,
      'bio': bio,
      'experienceYears': experienceYears,
      'gender': gender,
      'experiences': experiences,
      'isVerified': isVerified,
      'jobTitle': jobTitle,
    };
  }
}
