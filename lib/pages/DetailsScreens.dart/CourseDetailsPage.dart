import 'dart:io';

import 'package:afaq/models/CourseModel.dart';
import 'package:afaq/providers/Review_Provider.dart';
import 'package:afaq/widgets/cards/instructorCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:provider/provider.dart';

class CourseDetailsScreen extends StatefulWidget {
  final CourseModel course;

  const CourseDetailsScreen({super.key, required this.course});

  @override
  _CourseDetailsScreenState createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> {
  @override
  void initState() {
    super.initState();
    _loadCourseImage();
    _clearCache();
  }

  Future<void> _loadCourseImage() async {
    try {
      final file = await DefaultCacheManager()
          .getSingleFile(widget.course.imageUrl?.toString() ?? '');
      print(file);
    } catch (e) {
      print("Error loading image: $e");
    }
  }

  Future<void> _clearCache() async {
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
          icon: const Icon(Icons.arrow_back, color: Colors.white),
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
                if (course.imageUrl != null && course.imageUrl!.isNotEmpty)
                  _buildHeaderImage(constraints, course),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCourseTitle(constraints, course),
                      const SizedBox(height: 8),
                      _buildCourseSubtitle(course),
                      const SizedBox(height: 8),
                      _buildCourseRatingAndPrice(constraints, course),
                      const SizedBox(height: 16),
                      _buildCourseStats(course),
                      const SizedBox(height: 16),
                      _buildTabBar(constraints, course),
                      const SizedBox(height: 16),
                      _buildSectionTitle("What You'll Get"),
                      const SizedBox(height: 16),
                      _buildFeatureList(course.features),
                      const SizedBox(height: 16),
                      _buildSectionTitle("Instructor"),
                      _buildInstructorList(),
                      const SizedBox(height: 16),
                      _buildReviewsSection(),
                      _buildReviewList(course.reviewsList),
                      _buildAddReviewButton(),
                      const SizedBox(height: 16),
                      _buildSectionTitle("Objectives"),
                      const SizedBox(height: 8),
                      _buildFeatureList(course.objectives),
                      const SizedBox(height: 16),
                      _buildSectionTitle("Requirements"),
                      const SizedBox(height: 8),
                      _buildFeatureList(course.requirements),
                      const SizedBox(height: 16),
                      _buildSectionTitle("Lessons"),
                      const SizedBox(height: 8),
                      _buildFeatureList(course.lessons),
                      const SizedBox(height: 16),
                      if (course.startDate != null && course.endDate != null)
                        _buildCourseDatesCard(course),
                      if (course.category != null) _buildCategoryCard(course),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: _buildEnrollButton(course),
    );
  }

  Widget _buildHeaderImage(BoxConstraints constraints, CourseModel course) {
    if (course.imageUrl == null || course.imageUrl!.isEmpty) {
      return Container();
    }

    return SizedBox(
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
    );
  }

  Widget _buildCourseTitle(BoxConstraints constraints, CourseModel course) {
    return Text(
      course.title ?? 'No Title',
      style: TextStyle(
        fontSize: constraints.maxWidth > 600 ? 32 : 24,
        fontWeight: FontWeight.bold,
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }

  Widget _buildCourseSubtitle(CourseModel course) {
    return Text(
      course.subtitle ?? '',
      style: const TextStyle(fontSize: 16, color: Colors.grey),
    );
  }

  Widget _buildCourseRatingAndPrice(
      BoxConstraints constraints, CourseModel course) {
    return Row(
      children: [
        Icon(Icons.star, color: Colors.yellow[700], size: 20),
        const SizedBox(width: 4),
        Text(course.rating.toString(), style: const TextStyle(fontSize: 16)),
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
    );
  }

  Widget _buildCourseStats(CourseModel course) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStatItem(Icons.class_, "${course.classes ?? 0} Classes"),
        _buildStatItem(Icons.schedule, "${course.hours ?? 0} Hours"),
        _buildStatItem(
            Icons.people,
            course.targetStudents != null
                ? "${course.currentStudents ?? 0}/${course.targetStudents}"
                : "${course.currentStudents ?? 0} Students"),
      ],
    );
  }

  Widget _buildStatItem(IconData icon, String text) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue),
        const SizedBox(height: 4),
        Text(text, style: const TextStyle(color: Colors.black)),
      ],
    );
  }

  Widget _buildTabBar(BoxConstraints constraints, CourseModel course) {
    return DefaultTabController(
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
            height: constraints.maxWidth > 600 ? 300 : 150,
            child: TabBarView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    course.about ?? 'No information available',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
                const Center(child: Text("Curriculum content here")),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    );
  }

  Widget _buildFeatureList(List<String>? features) {
    return Column(
      children: features?.map((feature) {
            return _buildFeatureItem(FontAwesomeIcons.playCircle, feature);
          }).toList() ??
          [],
    );
  }

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

  Widget _buildInstructorList() {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: widget.course.instructors!.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              const SizedBox(height: 8),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: InstructorCard(
                    instructor: widget.course.instructors![index]),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildReviewsSection() {
    return Row(
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
    );
  }

  Widget _buildReviewList(List<Map<String, String>>? reviewsList) {
    return Column(
      children: reviewsList?.map((review) {
            return _buildReviewItem(
              review['name'] ?? 'Anonymous',
              review['review'] ?? 'No review',
              review['timeAgo'] ?? 'Unknown',
              int.tryParse(review['likes'] ?? '0') ?? 0,
              int.tryParse(review['rating']?.toString() ?? '0') ?? 0,
            );
          }).toList() ??
          [],
    );
  }

  Widget _buildReviewItem(
      String userId, String review, String timeAgo, int likes, int rating) {
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
                ClipOval(
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 2),
                      shape: BoxShape.circle,
                    ),
                    child: Image(
                      image: FileImage(File(widget.course.imageUrl.toString())),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FutureBuilder<String>(
                        future: FirebaseFirestore.instance
                            .collection('users')
                            .doc(userId)
                            .get()
                            .then((doc) => doc['profileImageUrl']),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return const Text('Error loading profile image');
                          } else {
                            return Text(
                              snapshot.data ?? 'No URL',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            );
                          }
                        },
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
                          Text(
                            "$likes Likes",
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 12),
                          ),
                          const Spacer(),
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
                      const SizedBox(height: 8),
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            index < rating ? Icons.star : Icons.star_border,
                            color: Colors.yellow[700],
                            size: 16,
                          );
                        }),
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

  Widget _buildAddReviewButton() {
    return TextButton(
      onPressed: () {
        _addReview(context);
      },
      child: const Text(
        "Add Review",
        style: TextStyle(color: Colors.blue, fontSize: 16),
      ),
    );
  }

  Widget ReviewCard(reviewModel) {
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
            ClipOval(
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 2),
                  shape: BoxShape.circle,
                ),
                child: Image(
                  image: FileImage(File(reviewModel.userId)),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder<String>(
                    future: FirebaseFirestore.instance
                        .collection('users')
                        .doc(reviewModel.userId)
                        .get()
                        .then((doc) => doc['profileImageUrl']),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return const Text('Error loading profile image');
                      } else {
                        return Text(
                          snapshot.data ?? 'No URL',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 4),
                  Text(
                    reviewModel.review,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => reviewModel.onLike(),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          transform: Matrix4.identity()
                            ..scale(reviewModel.isLiked ? 1.1 : 1.0),
                          child: Icon(
                            reviewModel.isLiked
                                ? Icons.thumb_up
                                : Icons.thumb_up_alt_outlined,
                            color: reviewModel.isLiked
                                ? Colors.blue
                                : Colors.grey[600],
                            size: 16,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () => reviewModel.onDislike(),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          transform: Matrix4.identity()
                            ..scale(reviewModel.isDisliked ? 1.1 : 1.0),
                          child: Icon(
                            reviewModel.isDisliked
                                ? Icons.thumb_down
                                : Icons.thumb_down_alt_outlined,
                            color: reviewModel.isDisliked
                                ? Colors.red
                                : Colors.grey[600],
                            size: 16,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "${reviewModel.likes} Likes",
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Icon(Icons.access_time,
                              color: Colors.grey[600], size: 16),
                          const SizedBox(width: 4),
                          Text(
                            reviewModel.timeAgo,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        index < reviewModel.rating
                            ? Icons.star
                            : Icons.star_border,
                        color: Colors.yellow[700],
                        size: 16,
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseDatesCard(CourseModel course) {
    return Card(
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
                Icon(Icons.calendar_today, color: Colors.blue),
                SizedBox(width: 8),
                Text(
                  "Course Dates",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              "Start Date: ${course.startDate.toString().substring(0, 10)}",
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 4),
            Text(
              "End Date: ${course.endDate?.toString().substring(0, 10) ?? 'No end date'}",
              style: const TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(CourseModel course) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.white,
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
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              course.category ?? 'No category',
              style: const TextStyle(color: Colors.black87, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEnrollButton(CourseModel course) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          // Enroll button action (link to logic)
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
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
              "Enroll Course - \$${course.price?.toStringAsFixed(2) ?? '0.00'}",
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  void _addReview(BuildContext context) {
    final TextEditingController reviewController = TextEditingController();
    int rating = 0;

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return IconButton(
                      icon: Icon(
                        index < rating ? Icons.star : Icons.star_border,
                        color: Colors.yellow[700],
                      ),
                      onPressed: () {
                        setState(() {
                          rating = index + 1;
                        });
                      },
                    );
                  }),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    final userId = FirebaseAuth.instance.currentUser!.uid;
                    final review = {
                      'courseId': widget.course.id,
                      'userId': userId,
                      'content': reviewController.text,
                      'rating': rating.toDouble(),
                      'createdAt': Timestamp.now(),
                    };

                    await FirebaseFirestore.instance
                        .collection('reviews')
                        .add(review);

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
                  child: Consumer<ReviewProvider>(
                    builder: (context, provider, child) {
                      return ListView(
                        children: provider.reviews
                            .where(
                                (review) => review.courseId == widget.course.id)
                            .map((review) => _buildReviewItem(
                                  review.userId,
                                  review.content,
                                  'Unknown',
                                  0,
                                  review.rating.toInt(),
                                ))
                            .toList(),
                      );
                    },
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
