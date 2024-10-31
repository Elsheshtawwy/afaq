import 'package:afaq/models/CourseModel.dart';
import 'package:afaq/models/InstructorModel.dart';
import 'package:afaq/pages/DetailsScreens.dart/CourseDetailsPage.dart';
import 'package:afaq/widgets/SearchBar.dart';
import 'package:afaq/widgets/cards/CourseCard.dart';
import 'package:afaq/widgets/categoryFilters.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CoursesScreen extends StatefulWidget {
  final List<CourseModel> courses;
  final List<InstructorModel> instructors;

  const CoursesScreen(
      {super.key, required this.courses, required this.instructors});

  @override
  _CoursesScreenState createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        searchQuery = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<CourseModel> filteredItems = widget.courses
        .where((item) =>
            item.title!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
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
              onPressed: () {
                const CustomSearchBar()
                    .showSearchDialog(context, _searchController, 'Course');
              },
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CategoryFilters(),
            Expanded(
              child: _buildCourseList(context, filteredItems),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseList(
      BuildContext context, List<CourseModel> filteredItems) {
    return ListView.builder(
      itemCount: filteredItems.length,
      itemBuilder: (context, index) {
        final course = filteredItems[index];
        return CourseCard(
          course: course,
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
