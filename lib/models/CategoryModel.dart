class CategoryModel {
  final String id;
  final String name;
  final String imageUrl;
   bool? isSelected;

  CategoryModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.isSelected = false,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'],
      name: map['name'],
      imageUrl: map['imageUrl'],
      isSelected: map['isSelected'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'isSelected': isSelected,
    };
  }
}
