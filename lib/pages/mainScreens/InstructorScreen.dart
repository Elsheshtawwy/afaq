import 'package:afaq/models/InstructorModel.dart';
import 'package:afaq/widgets/cards/instructorCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InstructorScreen extends StatelessWidget {
  final List<InstructorModel> instructors;
  const InstructorScreen({super.key, required this.instructors});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Top Mentors',
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
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: instructors.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: InstructorCard(
                    instructor: instructors[index],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
