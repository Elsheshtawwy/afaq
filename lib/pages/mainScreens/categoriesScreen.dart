import 'package:afaq/models/CategoryModel.dart';
import 'package:afaq/widgets/SearchBar.dart';
import 'package:afaq/widgets/cards/categoryItem.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  final List<CategoryModel> categories;

  const CategoriesScreen({super.key, required this.categories});

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
            Expanded(child: _CategoryGrid(categories: categories)),
          ],
        ),
      ),
    );
  }
}

class _CategoryGrid extends StatelessWidget {
  final List<CategoryModel> categories;

  const _CategoryGrid({required this.categories});

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
        final category = categories[index];
        return CategoryItem(category: category);
      },
    );
  }
}
