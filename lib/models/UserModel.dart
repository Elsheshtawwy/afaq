
class UserModel {
  final String id;
  final String name;
  final String email;
  final String? phoneNumber;
  final String password;
  final String? profilePicture;
  final String role; // "student", "instructor", "admin"
  final List<String>? coursesEnrolled;
  final List<String>? wishlist;
  final String? bio;
  final double? rating;
  final List<String>? reviews;
  final String? location;
  final List<String>? notifications;
  final Map<String, dynamic>? preferences;
  final DateTime joinedDate;
  final Map<String, dynamic>? paymentDetails;
  final bool isVerified;
  final DateTime lastLogin;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.role,
    required this.joinedDate,
    this.phoneNumber,
    this.profilePicture,
    this.coursesEnrolled,
    this.wishlist,
    this.bio,
    this.rating,
    this.reviews,
    this.location,
    this.notifications,
    this.preferences,
    this.paymentDetails,
    this.isVerified = false,
    required this.lastLogin,
  });

  // JSON serialization
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      role: json['role'],
      joinedDate: DateTime.parse(json['joinedDate']),
      phoneNumber: json['phoneNumber'],
      profilePicture: json['profilePicture'],
      coursesEnrolled: List<String>.from(json['coursesEnrolled'] ?? []),
      wishlist: List<String>.from(json['wishlist'] ?? []),
      bio: json['bio'],
      rating: json['rating']?.toDouble(),
      reviews: List<String>.from(json['reviews'] ?? []),
      location: json['location'],
      notifications: List<String>.from(json['notifications'] ?? []),
      preferences: json['preferences'],
      paymentDetails: json['paymentDetails'],
      isVerified: json['isVerified'] ?? false,
      lastLogin: DateTime.parse(json['lastLogin']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'password': password,
      'profilePicture': profilePicture,
      'role': role,
      'coursesEnrolled': coursesEnrolled,
      'wishlist': wishlist,
      'bio': bio,
      'rating': rating,
      'reviews': reviews,
      'location': location,
      'notifications': notifications,
      'preferences': preferences,
      'joinedDate': joinedDate.toIso8601String(),
      'paymentDetails': paymentDetails,
      'isVerified': isVerified,
      'lastLogin': lastLogin.toIso8601String(),
    };
  }

  // CopyWith method
  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phoneNumber,
    String? password,
    String? profilePicture,
    String? role,
    List<String>? coursesEnrolled,
    List<String>? wishlist,
    String? bio,
    double? rating,
    List<String>? reviews,
    String? location,
    List<String>? notifications,
    Map<String, dynamic>? preferences,
    DateTime? joinedDate,
    Map<String, dynamic>? paymentDetails,
    bool? isVerified,
    DateTime? lastLogin,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      role: role ?? this.role,
      joinedDate: joinedDate ?? this.joinedDate,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePicture: profilePicture ?? this.profilePicture,
      coursesEnrolled: coursesEnrolled ?? this.coursesEnrolled,
      wishlist: wishlist ?? this.wishlist,
      bio: bio ?? this.bio,
      rating: rating ?? this.rating,
      reviews: reviews ?? this.reviews,
      location: location ?? this.location,
      notifications: notifications ?? this.notifications,
      preferences: preferences ?? this.preferences,
      paymentDetails: paymentDetails ?? this.paymentDetails,
      isVerified: isVerified ?? this.isVerified,
      lastLogin: lastLogin ?? this.lastLogin,
    );
  }
}
