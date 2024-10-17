import 'package:afaq/widgets/SearchBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'All Categories',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          children: [
            CustomSearchBar(
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
  final List<_CategoryItem> categories = const [
    _CategoryItem(name: '3D Design', imageUrl: 'assets/categories/design.png'),
    _CategoryItem(
        name: 'Graphic Design',
        imageUrl: 'assets/categories/graphicDesign.png'),
    _CategoryItem(name: '3D Design', imageUrl: 'assets/categories/design.png'),
    _CategoryItem(
        name: 'Graphic Design',
        imageUrl: 'assets/categories/graphicDesign.png'),
    _CategoryItem(name: '3D Design', imageUrl: 'assets/categories/design.png'),
    _CategoryItem(
        name: 'Graphic Design',
        imageUrl: 'assets/categories/graphicDesign.png'),
    _CategoryItem(name: '3D Design', imageUrl: 'assets/categories/design.png'),
    _CategoryItem(
        name: 'Graphic Design',
        imageUrl: 'assets/categories/graphicDesign.png'),
    _CategoryItem(name: '3D Design', imageUrl: 'assets/categories/design.png'),
    _CategoryItem(
        name: 'Graphic Design',
        imageUrl: 'assets/categories/graphicDesign.png'),
    _CategoryItem(name: '3D Design', imageUrl: 'assets/categories/design.png'),
    _CategoryItem(
        name: 'Graphic Design',
        imageUrl: 'assets/categories/graphicDesign.png'),
    _CategoryItem(name: '3D Design', imageUrl: 'assets/categories/design.png'),
    _CategoryItem(
        name: 'Graphic Design',
        imageUrl: 'assets/categories/graphicDesign.png'),
    _CategoryItem(name: '3D Design', imageUrl: 'assets/categories/design.png'),
    _CategoryItem(
        name: 'Graphic Design',
        imageUrl: 'assets/categories/graphicDesign.png'),
    _CategoryItem(name: '3D Design', imageUrl: 'assets/categories/design.png'),
    _CategoryItem(
        name: 'Graphic Design',
        imageUrl: 'assets/categories/graphicDesign.png'),
    _CategoryItem(name: '3D Design', imageUrl: 'assets/categories/design.png'),
    _CategoryItem(
        name: 'Graphic Design',
        imageUrl: 'assets/categories/graphicDesign.png'),
    _CategoryItem(name: '3D Design', imageUrl: 'assets/categories/design.png'),
    _CategoryItem(
        name: 'Graphic Design',
        imageUrl: 'assets/categories/graphicDesign.png'),
    _CategoryItem(name: '3D Design', imageUrl: 'assets/categories/design.png'),
    _CategoryItem(
        name: 'Graphic Design',
        imageUrl: 'assets/categories/graphicDesign.png'),
    _CategoryItem(name: '3D Design', imageUrl: 'assets/categories/design.png'),
    _CategoryItem(
        name: 'Graphic Design',
        imageUrl: 'assets/categories/graphicDesign.png'),
    _CategoryItem(name: '3D Design', imageUrl: 'assets/categories/design.png'),
    _CategoryItem(
        name: 'Graphic Design',
        imageUrl: 'assets/categories/graphicDesign.png'),
    _CategoryItem(name: '3D Design', imageUrl: 'assets/categories/design.png'),
    _CategoryItem(
        name: 'Graphic Design',
        imageUrl: 'assets/categories/graphicDesign.png'),
    _CategoryItem(name: '3D Design', imageUrl: 'assets/categories/design.png'),
    _CategoryItem(
        name: 'Graphic Design',
        imageUrl: 'assets/categories/graphicDesign.png'),
    _CategoryItem(name: '3D Design', imageUrl: 'assets/categories/design.png'),
    _CategoryItem(
        name: 'Graphic Design',
        imageUrl: 'assets/categories/graphicDesign.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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

class _CategoryItem extends StatelessWidget {
  final String name;
  final String imageUrl;

  const _CategoryItem({required this.name, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.transparent,
          ),
          child: Image.asset(imageUrl),
        ),
        SizedBox(height: 16),
        Text(
          name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
