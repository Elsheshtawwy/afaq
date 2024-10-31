import 'package:afaq/models/InstituteModel.dart';
import 'package:afaq/pages/DetailsScreens.dart/CourseDetailsPage.dart';
import 'package:afaq/widgets/cards/CourseCard.dart';
import 'package:flutter/material.dart';

class InstitutesDetailsScreen extends StatelessWidget {
  final InstituteModel institute;

  const InstitutesDetailsScreen({super.key, required this.institute});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, 
      child: Scaffold(
        appBar: AppBar(
          title: Text(institute.name ?? 'Institute Details'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: institute.logoUrl != null
                            ? NetworkImage(institute.logoUrl!)
                            : null,
                        backgroundColor: Colors.grey[200],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        institute.name ?? 'Unknown Institute',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        institute.address ?? 'No Address Provided',
                        style:
                            const TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(institute.courses?.length.toString() ?? '0',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              const Text('Courses'),
                            ],
                          ),
                          const SizedBox(width: 30),
                          Column(
                            children: [
                              Text(
                                  institute.rating?.toStringAsFixed(1) ?? 'N/A',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              const Text('Rating'),
                            ],
                          ),
                          const SizedBox(width: 30),
                          Column(
                            children: [
                              Text(institute.reviews?.length.toString() ?? '0',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              const Text('Reviews'),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Follow and Message buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Handle Follow
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text('Follow'),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () {
                              // Handle Message
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text('Message'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // TabBar
                const SizedBox(
                  height: 50,
                  child: TabBar(
                    tabs: [
                      Tab(text: 'Courses'),
                      Tab(text: 'Instructors'),
                      Tab(text: 'Ratings'),
                    ],
                    labelColor: Colors.blue,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Colors.blue,
                  ),
                ),
                const SizedBox(height: 20),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: institute.courses?.length ?? 0,
                  itemBuilder: (context, index) {
                    final course = institute.courses![index];
                    return CourseCard(
                      course: course,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CourseDetailsScreen(course: course),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
