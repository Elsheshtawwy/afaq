import 'package:afaq/models/CourseModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CourseCardHome extends StatelessWidget {
  final CourseModel course;
  final Color bgColor;
  final double width;
  final VoidCallback? onTap;

  const CourseCardHome({
    super.key,
    required this.course,
    required this.bgColor,
    this.width = 270,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 0.8;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: cardWidth,
          height: 240,
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImage(cardWidth),
              _buildCourseInfo(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage(double width) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      child: CachedNetworkImage(
        imageUrl: course.imageUrl![0].toString() ?? '',
        height: 120,
        width: width,
        fit: BoxFit.fill,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }

  Widget _buildCourseInfo() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              course.title ?? '',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            LayoutBuilder(
              builder: (context, constraints) {
                double fontSize = constraints.maxWidth > 350 ? 14 : 12;
                return Text(
                  course.subtitle ?? '',
                  style: TextStyle(
                    fontSize: fontSize,
                    color: Colors.grey[600],
                  ),
                );
              },
            ),
            const Spacer(),
            Row(
              children: [
                Text(
                  course.price?.toString() ?? '',
                  style: const TextStyle(color: Colors.blue),
                ),
                const Spacer(),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.yellow, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      course.rating?.toString() ?? '',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '(${course.numberOfRatings ?? 0}) Std',
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
