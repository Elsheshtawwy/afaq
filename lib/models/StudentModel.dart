import 'dart:convert';

class Instructor {
  final String id;
  final String name;
  final String email;
  final String department;
  final String phoneNumber;
  final String officeLocation;

  Instructor({
    required this.id,
    required this.name,
    required this.email,
    required this.department,
    required this.phoneNumber,
    required this.officeLocation,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'department': department,
      'phoneNumber': phoneNumber,
      'officeLocation': officeLocation,
    };
  }

  factory Instructor.fromMap(Map<String, dynamic> map) {
    return Instructor(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      department: map['department'],
      phoneNumber: map['phoneNumber'],
      officeLocation: map['officeLocation'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Instructor.fromJson(String source) => Instructor.fromMap(json.decode(source));
}