import 'package:afaq/widgets/SearchBar.dart';
import 'package:afaq/widgets/cards/categoryItem.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'All Categories',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          children: [
            const CustomSearchBar(
              hintText: 'Search for',
            ),
            Expanded(child: _CategoryGrid()),
          ],
        ),
      ),
    );
  }
}

class _CategoryGrid extends StatelessWidget {
  final List<CategoryItem> categories = const [
    CategoryItem(name: '3D Design', imageUrl: 'assets/categories/design.png'),
    CategoryItem(
        name: 'Graphic Design',
        imageUrl: 'assets/categories/graphicDesign.png'),
    CategoryItem(name: '3D Design', imageUrl: 'assets/categories/design.png'),
    CategoryItem(
        name: 'Graphic Design',
        imageUrl: 'assets/categories/graphicDesign.png'),
    CategoryItem(name: '3D Design', imageUrl: 'assets/categories/design.png'),
    CategoryItem(
        name: 'Graphic Design',
        imageUrl: 'assets/categories/graphicDesign.png'),
    CategoryItem(name: '3D Design', imageUrl: 'assets/categories/design.png'),
    CategoryItem(
        name: 'Graphic Design',
        imageUrl: 'assets/categories/graphicDesign.png'),
    CategoryItem(name: '3D Design', imageUrl: 'assets/categories/design.png'),
    CategoryItem(
        name: 'Graphic Design',
        imageUrl: 'assets/categories/graphicDesign.png'),
    CategoryItem(name: '3D Design', imageUrl: 'assets/categories/design.png'),
    CategoryItem(
        name: 'Graphic Design',
        imageUrl: 'assets/categories/graphicDesign.png'),
    CategoryItem(name: '3D Design', imageUrl: 'assets/categories/design.png'),
    CategoryItem(
        name: 'Graphic Design',
        imageUrl: 'assets/categories/graphicDesign.png'),
    CategoryItem(name: '3D Design', imageUrl: 'assets/categories/design.png'),
    CategoryItem(
        name: 'Graphic Design',
        imageUrl: 'assets/categories/graphicDesign.png'),
    CategoryItem(name: '3D Design', imageUrl: 'assets/categories/design.png'),
    CategoryItem(
        name: 'Graphic Design',
        imageUrl: 'assets/categories/graphicDesign.png'),
    CategoryItem(name: '3D Design', imageUrl: 'assets/categories/design.png'),
    CategoryItem(
        name: 'Graphic Design',
        imageUrl: 'assets/categories/graphicDesign.png'),
    CategoryItem(name: '3D Design', imageUrl: 'assets/categories/design.png'),
    CategoryItem(
        name: 'Graphic Design',
        imageUrl: 'assets/categories/graphicDesign.png'),
    CategoryItem(name: '3D Design', imageUrl: 'assets/categories/design.png'),
    CategoryItem(
        name: 'Graphic Design',
        imageUrl: 'assets/categories/graphicDesign.png'),
    CategoryItem(name: '3D Design', imageUrl: 'assets/categories/design.png'),
    CategoryItem(
        name: 'Graphic Design',
        imageUrl: 'assets/categories/graphicDesign.png'),
    CategoryItem(name: '3D Design', imageUrl: 'assets/categories/design.png'),
    CategoryItem(
        name: 'Graphic Design',
        imageUrl: 'assets/categories/graphicDesign.png'),
    CategoryItem(name: '3D Design', imageUrl: 'assets/categories/design.png'),
    CategoryItem(
        name: 'Graphic Design',
        imageUrl: 'assets/categories/graphicDesign.png'),
    CategoryItem(name: '3D Design', imageUrl: 'assets/categories/design.png'),
    CategoryItem(
        name: 'Graphic Design',
        imageUrl: 'assets/categories/graphicDesign.png'),
    CategoryItem(name: '3D Design', imageUrl: 'assets/categories/design.png'),
    CategoryItem(
        name: 'Graphic Design',
        imageUrl: 'assets/categories/graphicDesign.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        childAspectRatio: 1,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return categories[index];
      },
    );
  }
}

