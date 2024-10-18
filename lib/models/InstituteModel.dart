class Institute {
  final String id;
  final String name;
  final String address;
  final String contactNumber;

  Institute({
    required this.id,
    required this.name,
    required this.address,
    required this.contactNumber,
  });

  factory Institute.fromMap(Map<String, dynamic> map) {
    return Institute(
      id: map['id'],
      name: map['name'],
      address: map['address'],
      contactNumber: map['contactNumber'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'contactNumber': contactNumber,
    };
  }
}