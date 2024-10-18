import 'package:afaq/models/CourseModel.dart';
import 'package:flutter/material.dart';

class CourseDetailsScreen extends StatelessWidget {
  final CourseModel course;

  CourseDetailsScreen({required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                course.title ?? 'No Title',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.yellow[700], size: 20),
                  const SizedBox(width: 4),
                  Text(course.rating?.toString() ?? '0.0', style: TextStyle(fontSize: 16)),
                  const SizedBox(width: 4),
                  Text("(${course.reviews ?? 0} reviews)", style: TextStyle(color: Colors.grey)),
                  Spacer(),
                  Text(
                    "\$${course.price ?? 0}",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.class_, color: Colors.grey),
                  const SizedBox(width: 8),
                  Text("${course.classes ?? 0} Classes", style: TextStyle(color: Colors.grey)),
                  const SizedBox(width: 16),
                  Icon(Icons.schedule, color: Colors.grey),
                  const SizedBox(width: 8),
                  Text("${course.hours ?? 0} Hours", style: TextStyle(color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 16),
              // Tab Bar
              DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    TabBar(
                      tabs: [
                        Tab(text: "About"),
                        Tab(text: "Curriculum"),
                      ],
                      labelColor: Colors.black,
                      indicatorColor: Colors.blue,
                    ),
                    Container(
                      height: 150, // Tab content height
                      child: TabBarView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              course.about ?? 'No information available',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          Center(child: Text("Curriculum content here")),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "What You'll Get",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 16),
              Column(
                children: course.features?.map((feature) {
                  return _buildFeatureItem(Icons.play_circle_fill, feature);
                }).toList() ?? [],
              ),
              const SizedBox(height: 16),
              // Instructor
              Text(
                "Instructor",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),
              ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(course.instructorImage ?? ''),
                ),
                title: Text(course.instructorName ?? 'No Name'),
                subtitle: Text(course.instructor ?? 'No Information'),
                trailing: IconButton(
                  icon: Icon(Icons.play_circle_fill),
                  onPressed: () {},
                ),
              ),
              const SizedBox(height: 16),
              // Reviews Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Reviews",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text("SEE ALL"),
                  ),
                ],
              ),
              Column(
                children: course.reviewsList?.map((review) {
                  return _buildReviewItem(
                    review['name'] ?? 'Anonymous',
                    review['review'] ?? 'No review',
                    review['timeAgo'] ?? 'Unknown',
                    review['likes'] ?? '0',
                  );
                }).toList() ?? [],
              ),
              const SizedBox(height: 16),
              // Objectives Section
              Text(
                "Objectives",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),
              Column(
                children: course.objectives?.map((objective) {
                  return _buildFeatureItem(Icons.check_circle, objective);
                }).toList() ?? [],
              ),
              const SizedBox(height: 16),
              // Requirements Section
              Text(
                "Requirements",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),
              Column(
                children: course.requirements?.map((requirement) {
                  return _buildFeatureItem(Icons.check_circle_outline, requirement);
                }).toList() ?? [],
              ),
              const SizedBox(height: 16),
              // Lessons Section
              Text(
                "Lessons",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),
              Column(
                children: course.lessons?.map((lesson) {
                  return _buildFeatureItem(Icons.book, lesson);
                }).toList() ?? [],
              ),
            ],
          ),
        ),
      ),
      // Sticky enroll button at the bottom
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            // Enroll action
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.play_circle_fill),
              const SizedBox(width: 8),
              Text("Enroll Course - \$${course.price ?? 0}", style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build feature list item
  Widget _buildFeatureItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 16),
          Text(text, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  // Helper method to build review list item
  Widget _buildReviewItem(String name, String review, String timeAgo, String likes) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage('assets/reviewer.jpg'), // Replace with actual image
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(width: 8),
                    Icon(Icons.star, color: Colors.yellow[700], size: 16),
                    const SizedBox(width: 4),
                    Text("4.5", style: TextStyle(fontSize: 14)),
                  ],
                ),
                Text(review, maxLines: 2, overflow: TextOverflow.ellipsis),
                Row(
                  children: [
                    Text("$likes Likes", style: TextStyle(color: Colors.grey, fontSize: 12)),
                    const SizedBox(width: 16),
                    Text(timeAgo, style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
