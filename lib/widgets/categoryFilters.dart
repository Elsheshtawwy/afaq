import 'package:flutter/material.dart';

class CategoryFilters extends StatefulWidget {
  final Color activeColor;
  final Color inactiveColor;
  final Color activeTextColor;
  final Color inactiveTextColor;
  final double horizontalPadding;
  final double verticalPadding;
  final double borderRadius;

  CategoryFilters({
    this.activeColor = Colors.green,
    this.inactiveColor = const Color(0xFFEEEEEE),
    this.activeTextColor = Colors.white,
    this.inactiveTextColor = Colors.black,
    this.horizontalPadding = 16.0,
    this.verticalPadding = 8.0,
    this.borderRadius = 20.0,
  });

  @override
  _CategoryFiltersState createState() => _CategoryFiltersState();
}

class _CategoryFiltersState extends State<CategoryFilters> {
  String selectedCategory = 'All';
  final List<String> categories = [
    'All',
    'Graphic Design',
    '3D Design',
    'Arts & Crafts'
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        child: Row(
          children:
              categories.map((category) => _buildFilterChip(category)).toList(),
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    bool isActive = label == selectedCategory;

    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedCategory = label;
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: widget.horizontalPadding,
              vertical: widget.verticalPadding),
          decoration: BoxDecoration(
            color: isActive ? widget.activeColor : widget.inactiveColor,
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          child: Text(
            label,
            style: TextStyle(
              color:
                  isActive ? widget.activeTextColor : widget.inactiveTextColor,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
