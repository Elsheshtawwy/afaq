import 'package:afaq/widgets/cards/CourseCard.dart';
import 'package:afaq/widgets/categoryFilters.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PopularCourses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Popular Courses',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              icon: Icon(CupertinoIcons.search, color: Colors.black),
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CategoryFilters(),
            Expanded(
              child: _buildCourseList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseList() {
    return ListView(
      children: [
        CourseCard(
          title: 'Graphic Design Advanced',
          category: 'Graphic Design',
          price: '\$28',
          oldPrice: '\$42',
          rating: 4.2,
          students: 7830,
          imageUrl: 'https://via.placeholder.com/150',
        ),
        CourseCard(
          title: 'Advertisement Design',
          category: 'Graphic Design',
          price: '\$42',
          oldPrice: '\$61',
          rating: 3.9,
          students: 12680,
          imageUrl: 'https://via.placeholder.com/150',
        ),
        CourseCard(
          title: 'Web Developer Concepts',
          category: 'Web Development',
          price: '\$56',
          oldPrice: '\$71',
          rating: 4.9,
          students: 14580,
          imageUrl: 'https://via.placeholder.com/150',
        ),
      ],
    );
  }

}




