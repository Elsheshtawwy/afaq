import 'package:afaq/models/InstructorModel.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MentorAvatar extends StatelessWidget {
  final InstructorModel instructor;

  const MentorAvatar({super.key, required this.instructor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: instructor.profilePicture.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: instructor.profilePicture,
                      placeholder: (context, url) => const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                      fit: BoxFit.cover,
                    )
                  : const Icon(Icons.person, size: 50, color: Colors.grey),
            ),
          ),
          const SizedBox(height: 12),
          AutoSizeText(
            instructor.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            maxLines: 1,
            textAlign: TextAlign.center,
          ),
          const AutoSizeText(
            'Top Mentor',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
            maxLines: 1,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}