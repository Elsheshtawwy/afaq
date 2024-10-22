
class InstructorModel {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String department;
  final String profilePicture;
  final List<String> institutesID;
  final List<String>? coursesTaught;
  final List<String>? qualifications;
  final String? bio;
  final int? experienceYears;
  final String? gender;
  final List<String>? experiences; 
  final String? specialization; 
  final bool? isVerified; 

  InstructorModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.department,
    required this.profilePicture,
    required this.institutesID,
    this.coursesTaught,
    this.qualifications,
    this.bio,
    this.experienceYears,
    this.gender, 
    this.experiences, 
    this.specialization, 
    this.isVerified, 
  });

  factory InstructorModel.fromJson(Map<String, dynamic> json) {
    return InstructorModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      department: json['department'],
      profilePicture: json['profilePicture'],
      institutesID: List<String>.from(json['institutesID']),
      coursesTaught: json['coursesTaught'] != null ? List<String>.from(json['coursesTaught']) : null,
      qualifications: json['qualifications'] != null ? List<String>.from(json['qualifications']) : null,
      bio: json['bio'],
      experienceYears: json['experienceYears'],
      gender: json['gender'],
      experiences: json['experiences'] != null ? List<String>.from(json['experiences']) : null,
      specialization: json['specialization'],
      isVerified: json['isVerified'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'department': department,
      'profilePicture': profilePicture,
      'institutesID': institutesID,
      'coursesTaught': coursesTaught,
      'qualifications': qualifications,
      'bio': bio,
      'experienceYears': experienceYears,
      'gender': gender,
      'experiences': experiences,
      'specialization': specialization,
      'isVerified': isVerified,
    };
  }
}
