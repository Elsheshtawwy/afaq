import 'package:afaq/widgets/cards/instructorCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InstructorScreen extends StatefulWidget {
  const InstructorScreen({super.key});

  @override
  _InstructorScreenState createState() => _InstructorScreenState();
}

class _InstructorScreenState extends State<InstructorScreen> {
  final List<InstructorCard> instructors = [
    const InstructorCard(
        name: 'John Doe',
        title: 'Software Engineer',
        profilePicture: 'https://example.com/images/john_doe.png'),
    const InstructorCard(
        name: 'Jane Smith',
        title: 'Data Scientist',
        profilePicture: 'https://example.com/images/jane_smith.png'),
    const InstructorCard(
        name: 'Alice Johnson',
        title: 'Product Manager',
        profilePicture: 'https://example.com/images/alice_johnson.png'),
    const InstructorCard(
        name: 'Bob Brown',
        title: 'UX Designer',
        profilePicture: 'https://example.com/images/bob_brown.png'),
    const InstructorCard(
        name: 'Charlie Davis',
        title: 'DevOps Engineer',
        profilePicture: 'https://example.com/images/charlie_davis.png'),
    const InstructorCard(
        name: 'Diana Evans',
        title: 'AI Researcher',
        profilePicture: 'https://example.com/images/diana_evans.png'),
    const InstructorCard(
        name: 'Ethan Foster',
        title: 'Cybersecurity Expert',
        profilePicture: 'https://example.com/images/ethan_foster.png'),
    const InstructorCard(
        name: 'Fiona Green',
        title: 'Cloud Architect',
        profilePicture: 'https://example.com/images/fiona_green.png')
  ];

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
                    name: instructors[index].name,
                    title: instructors[index].title,
                    profilePicture: instructors[index].profilePicture,
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
