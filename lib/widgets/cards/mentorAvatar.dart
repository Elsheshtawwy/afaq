import 'package:afaq/models/InstructorModel.dart';
import 'package:flutter/material.dart';

class MentorAvatar extends StatelessWidget {
  final InstructorModel instructor;

  const MentorAvatar({super.key, required this.instructor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: NetworkImage(instructor.profilePicture),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(instructor.name,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const Text('Top Mentor',
              style: TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }
}
