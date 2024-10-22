import 'dart:io';
import 'package:afaq/models/CourseModel.dart';
import 'package:afaq/models/InstructorModel.dart';
import 'package:afaq/widgets/cards/instructorCard.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CourseDetailsScreen extends StatefulWidget {
  final CourseModel course;
  final List<InstructorModel> instructors;

  const CourseDetailsScreen(
      {super.key, required this.course, required this.instructors});

  @override
  _CourseDetailsScreenState createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> {
  initState() {
    super.initState();
    final file =
        DefaultCacheManager().getSingleFile(widget.course.imageUrl.toString());
    print(file);
    clearCache();
  }

  Future<void> clearCache() async {
    await DefaultCacheManager().emptyCache();
    print("Cache cleared!");
  }

  @override
  Widget build(BuildContext context) {
    final course = widget.course;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Image
                if (course.imageUrl != null && course.imageUrl!.isNotEmpty)
                  SizedBox(
                    height: constraints.maxWidth > 600 ? 300 : 200,
                    child: Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        return Image.network(
                          course.imageUrl![index],
                          fit: BoxFit.cover,
                          width: double.infinity,
                        );
                      },
                      itemCount: course.imageUrl!.length,
                      pagination: const SwiperPagination(),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        course.title ?? 'No Title',
                        style: TextStyle(
                          fontSize: constraints.maxWidth > 600 ? 32 : 24,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        course.subtitle ?? '',
                        style:
                            const TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.yellow[700], size: 20),
                          const SizedBox(width: 4),
                          Text(course.rating.toString(),
                              style: const TextStyle(fontSize: 16)),
                          const SizedBox(width: 4),
                          Text("(${course.reviews ?? 0} reviews)",
                              style: const TextStyle(color: Colors.grey)),
                          const Spacer(),
                          if (course.oldPrice != null)
                            Text(
                              "\$${course.oldPrice}",
                              style: TextStyle(
                                fontSize: constraints.maxWidth > 600 ? 24 : 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          const SizedBox(width: 8),
                          Text(
                            "\$${course.price ?? 0}",
                            style: TextStyle(
                              fontSize: constraints.maxWidth > 600 ? 32 : 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              const Icon(Icons.class_, color: Colors.blue),
                              const SizedBox(height: 4),
                              Text("${course.classes ?? 0} Classes",
                                  style: const TextStyle(color: Colors.black)),
                            ],
                          ),
                          Column(
                            children: [
                              const Icon(Icons.schedule, color: Colors.blue),
                              const SizedBox(height: 4),
                              Text("${course.hours ?? 0} Hours",
                                  style: const TextStyle(color: Colors.black)),
                            ],
                          ),
                          Column(
                            children: [
                              const Icon(Icons.people, color: Colors.blue),
                              const SizedBox(height: 4),
                              Text(
                                  course.targetStudents != null
                                      ? "${course.currentStudents ?? 0}/${course.targetStudents}"
                                      : "${course.currentStudents ?? 0} Students",
                                  style: const TextStyle(color: Colors.black)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Tab Bar
                      DefaultTabController(
                        length: 2,
                        child: Column(
                          children: [
                            const TabBar(
                              tabs: [
                                Tab(text: "About"),
                                Tab(text: "Curriculum"),
                              ],
                              labelColor: Colors.black,
                              indicatorColor: Colors.blue,
                            ),
                            SizedBox(
                              height: constraints.maxWidth > 600
                                  ? 300
                                  : 150, // Tab content height
                              child: TabBarView(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      course.about ??
                                          'No information available',
                                      style:
                                          const TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                  const Center(
                                      child: Text("Curriculum content here")),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "What You'll Get",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Column(
                        children: course.features?.map((feature) {
                              return _buildFeatureItem(
                                  FontAwesomeIcons.playCircle, feature);
                            }).toList() ??
                            [],
                      ),
                      const SizedBox(height: 16),
                      // Instructor
                      const Text(
                        "Instructor",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 200, // Set a fixed height for the ListView
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          itemCount: widget.instructors.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                const SizedBox(
                                  height: 8,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  child: InstructorCard(
                                    instructor: widget.instructors[index],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 16),
                      // Reviews Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Reviews",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              _seeAllReviews(context);
                            },
                            child: const Text(
                              "SEE ALL",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: course.reviewsList?.map((review) {
                              return _buildReviewItem(
                                review['name'] ?? 'Anonymous',
                                review['review'] ?? 'No review',
                                review['timeAgo'] ?? 'Unknown',
                                int.tryParse(review['likes'] ?? '0') ?? 0,
                              );
                            }).toList() ??
                            [],
                      ),
                      TextButton(
                          onPressed: () {
                            _addReview(context);
                          },
                          child: const Text(
                            "Add Review",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16,
                            ),
                          )),
                      const SizedBox(height: 16),
                      // Objectives Section
                      const Text(
                        "Objectives",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Column(
                        children: course.objectives?.map((objective) {
                              return _buildFeatureItem(
                                  FontAwesomeIcons.checkCircle, objective);
                            }).toList() ??
                            [],
                      ),
                      const SizedBox(height: 16),
                      // Requirements Section
                      const Text(
                        "Requirements",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Column(
                        children: course.requirements?.map((requirement) {
                              return _buildFeatureItem(
                                  FontAwesomeIcons.checkCircle, requirement);
                            }).toList() ??
                            [],
                      ),
                      const SizedBox(height: 16),
                      // Lessons Section
                      const Text(
                        "Lessons",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Column(
                        children: course.lessons?.map((lesson) {
                              return _buildFeatureItem(
                                  FontAwesomeIcons.book, lesson);
                            }).toList() ??
                            [],
                      ),
                      const SizedBox(height: 16),
                      // Course Dates
                      // Course Dates Section
                      if (course.startDate != null && course.endDate != null)
                        Card(
                          color: Colors.white,
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(
                                  children: [
                                    Icon(Icons.calendar_today,
                                        color: Colors.blue),
                                    SizedBox(width: 8),
                                    Text(
                                      "Course Dates",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Start Date: ${course.startDate}",
                                  style: const TextStyle(color: Colors.black),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "End Date: ${course.endDate}",
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),

// Course Category Section
                      if (course.category != null)
                        Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          color: Colors.white, // Added background color
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(
                                  children: [
                                    Icon(Icons.category, color: Colors.blue),
                                    SizedBox(width: 8),
                                    Text(
                                      "Category",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  course.category!,
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
            // Handle enrollment logic here
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: Colors.blue,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(FontAwesomeIcons.playCircle, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                "Enroll Course - \$${course.price ?? 0}",
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
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
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Icon(icon, color: Colors.blue, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewItem(
      String name, String review, String timeAgo, int likes) {
    bool isLiked = false;
    bool isDisliked = false;

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Card(
          color: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar with border
                ClipOval(
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 2),
                      shape: BoxShape.circle,
                    ),
                    child: Image(
                      image: FileImage(
                          File(widget.course.imageUrl.toString() ?? '')),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        review,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 14, color: Colors.black87),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isLiked = !isLiked;
                                if (isLiked) {
                                  likes++;
                                  if (isDisliked) {
                                    isDisliked = false;
                                    likes++;
                                  }
                                } else {
                                  likes--;
                                }
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              transform: Matrix4.identity()
                                ..scale(isLiked ? 1.1 : 1.0),
                              child: Icon(
                                isLiked
                                    ? Icons.thumb_up
                                    : Icons.thumb_up_alt_outlined,
                                color: isLiked ? Colors.blue : Colors.grey[600],
                                size: 16,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),

                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isDisliked = !isDisliked;
                                if (isDisliked) {
                                  likes--;
                                  if (isLiked) {
                                    isLiked = false;
                                    likes--;
                                  }
                                } else {
                                  likes++;
                                }
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              transform: Matrix4.identity()
                                ..scale(isDisliked ? 1.1 : 1.0),
                              child: Icon(
                                isDisliked
                                    ? Icons.thumb_down
                                    : Icons.thumb_down_alt_outlined,
                                color:
                                    isDisliked ? Colors.red : Colors.grey[600],
                                size: 16,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),

                          // Like count
                          Text(
                            "$likes Likes",
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 12),
                          ),
                          const Spacer(),

                          // Time ago
                          Row(
                            children: [
                              Icon(Icons.access_time,
                                  color: Colors.grey[600], size: 16),
                              const SizedBox(width: 4),
                              Text(
                                timeAgo,
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Method to add a new review
  void _addReview(BuildContext context) {
    final TextEditingController reviewController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Add Review',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: reviewController,
                  decoration: const InputDecoration(
                    labelText: 'Review',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      widget.course.reviewsList?.add({
                        'name': 'Current User',
                        'review': reviewController.text,
                        'timeAgo': 'Just now',
                        'likes': '0',
                      });
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text('Add Review'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _seeAllReviews(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'All Reviews',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView(
                    children: widget.course.reviewsList?.map((review) {
                          return _buildReviewItem(
                            review['name'] ?? 'Anonymous',
                            review['review'] ?? 'No review',
                            review['timeAgo'] ?? 'Unknown',
                            int.tryParse(review['likes'] ?? '0') ?? 0,
                          );
                        }).toList() ??
                        [],
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
