import 'package:afaq/models/CourseModel.dart';
import 'package:afaq/models/InstructorModel.dart';
import 'package:afaq/pages/DetailsScreens.dart/CourseDetailsPage.dart';
import 'package:afaq/widgets/cards/CourseCard.dart';
import 'package:afaq/widgets/categoryFilters.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CoursesScreen extends StatelessWidget {
  final List<CourseModel> courses;
  final List<InstructorModel> instructors;

  const CoursesScreen(
      {super.key, required this.courses, required this.instructors});

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
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            'Popular Courses',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              icon: const Icon(CupertinoIcons.search, color: Colors.black),
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CategoryFilters(),
            Expanded(
              child: _buildCourseList(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseList(BuildContext context) {
    return ListView.builder(
      itemCount: courses.length,
      itemBuilder: (context, index) {
        final course = courses[index];
        return CourseCard(
          course: courses[index],
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CourseDetailsScreen(course: course),
              ),
            );
          },
        );
      },
    );
  }
}
