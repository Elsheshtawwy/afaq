import 'package:afaq/widgets/cards/mentorCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopMentorScreen extends StatefulWidget {
  const TopMentorScreen({Key? key}) : super(key: key);

  @override
  _TopMentorScreenState createState() => _TopMentorScreenState();
}

class _TopMentorScreenState extends State<TopMentorScreen> {
  final List<MentorCard> mentors = [
    const MentorCard(
        name: 'John Doe',
        title: 'Software Engineer',
        profilePicture: 'https://example.com/images/john_doe.png'),
    const MentorCard(
        name: 'Jane Smith',
        title: 'Data Scientist',
        profilePicture: 'https://example.com/images/jane_smith.png'),
    const MentorCard(
        name: 'Alice Johnson',
        title: 'Product Manager',
        profilePicture: 'https://example.com/images/alice_johnson.png'),
    const MentorCard(
        name: 'Bob Brown',
        title: 'UX Designer',
        profilePicture: 'https://example.com/images/bob_brown.png'),
    const MentorCard(
        name: 'Charlie Davis',
        title: 'DevOps Engineer',
        profilePicture: 'https://example.com/images/charlie_davis.png'),
    const MentorCard(
        name: 'Diana Evans',
        title: 'AI Researcher',
        profilePicture: 'https://example.com/images/diana_evans.png'),
    const MentorCard(
        name: 'Ethan Foster',
        title: 'Cybersecurity Expert',
        profilePicture: 'https://example.com/images/ethan_foster.png'),
    const MentorCard(
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
              itemCount: mentors.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: MentorCard(
                    name: mentors[index].name,
                    title: mentors[index].title,
                    profilePicture: mentors[index].profilePicture,
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
