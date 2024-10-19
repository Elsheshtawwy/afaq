class Institute {
  final String id;
  final String name;
  final String address;
  final List<String> contactNumbers;
  final String? email;

  Institute({
    required this.id,
    required this.name,
    required this.address,
    required this.contactNumbers,
    this.email,
  });

  factory Institute.fromMap(Map<String, dynamic> map) {
    return Institute(
      id: map['id'],
      name: map['name'],
      address: map['address'],
      contactNumbers: List<String>.from(map['contactNumbers']),
      email: map['email'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'contactNumbers': contactNumbers,
      'email': email,
    };
  }
}