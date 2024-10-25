import 'package:flutter/material.dart';
import 'package:afaq/models/InstructorModel.dart';
import 'package:afaq/pages/mainScreens/CourseDetailsPage.dart';
import 'package:afaq/widgets/cards/CourseCard.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // For icons

class InstructorDetailsScreen extends StatefulWidget {
  final InstructorModel instructor;

  const InstructorDetailsScreen({super.key, required this.instructor});

  @override
  _InstructorDetailsScreenState createState() =>
      _InstructorDetailsScreenState();
}

class _InstructorDetailsScreenState extends State<InstructorDetailsScreen> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final instructor = widget.instructor;

    return DefaultTabController(
      length: 3, 
      child: Scaffold(
        appBar: AppBar(
          title: Text(instructor.name ?? 'Instructor Details'),
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
                // Handle more options
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Center(child: _buildProfileSection(instructor)),
                const SizedBox(height: 20),
                if (instructor.bio != null) _buildBioSection(instructor.bio!),
                if (_isExpanded) _buildAdditionalInfo(instructor),
                const Divider(thickness: 1),
                const SizedBox(height: 10),
                _buildTabBar(),
                const SizedBox(height: 20),
                _buildCourseList(instructor),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection(InstructorModel instructor) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: instructor.profilePicture != null
              ? NetworkImage(instructor.profilePicture)
              : const AssetImage('assets/profile.png') as ImageProvider,
          backgroundColor: Colors.grey[200],
        ),
        const SizedBox(height: 10),
        Text(
          instructor.name ?? '',
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          instructor.jobTitle ?? '',
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
        const SizedBox(height: 10),
        _buildStatsRow(instructor),
        const SizedBox(height: 20),
        _buildActionButtons(),
      ],
    );
  }

  Widget _buildStatsRow(InstructorModel instructor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildStatColumn(FontAwesomeIcons.bookOpen, Colors.blue,
            (instructor.coursesTaught?.length ?? 0).toString(), 'Courses'),
        const SizedBox(width: 30),
        _buildStatColumn(FontAwesomeIcons.solidClock, Colors.orange,
            (instructor.experienceYears ?? 0).toString(), 'Years'),
      ],
    );
  }

  Widget _buildStatColumn(
      IconData icon, Color color, String value, String label) {
    return Column(
      children: [
        FaIcon(icon, color: color),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Text(label),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            // Handle Follow
          },
          icon: const Icon(Icons.person_add, color: Colors.white),
          label: const Text('Follow'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        const SizedBox(width: 10),
        ElevatedButton.icon(
          onPressed: () {
            // Handle Message
          },
          icon: const Icon(Icons.message, color: Colors.white),
          label: const Text('Message'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBioSection(String bio) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(thickness: 1),
        const SizedBox(height: 10),
        const Row(
          children: [
            FaIcon(FontAwesomeIcons.infoCircle, color: Colors.blue),
            SizedBox(width: 10),
            Text(
              'Bio',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(bio),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildAdditionalInfo(InstructorModel instructor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (instructor.qualifications != null &&
            instructor.qualifications!.isNotEmpty)
          _buildExpandableSection(
              FontAwesomeIcons.graduationCap, Colors.orange, 'Qualifications', instructor.qualifications!),
        if (instructor.experiences != null && instructor.experiences!.isNotEmpty)
          _buildExpandableSection(
              FontAwesomeIcons.briefcase, Colors.purple, 'Experiences', instructor.experiences!),
        if (instructor.gender != null)
          _buildExpandableSection(
              FontAwesomeIcons.venusMars, Colors.pink, 'Gender', [instructor.gender!]),
        if (instructor.isVerified != null && instructor.isVerified == true)
          _buildExpandableSection(
              FontAwesomeIcons.checkCircle, Colors.green, 'Verified', ['Verified']),
        if (instructor.institutes != null && instructor.institutes!.isNotEmpty)
          _buildExpandableSection(
              FontAwesomeIcons.university, Colors.brown, 'Institutes', instructor.institutes!.map((e) => e.name).toList()),
      ],
    );
  }

  Widget _buildExpandableSection(
      IconData icon, Color color, String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                FaIcon(icon, color: color),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            IconButton(
              icon: Icon(_isExpanded ? Icons.remove : Icons.add),
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 10),
        for (var item in items) Text('- $item'),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildTabBar() {
    return const TabBar(
      tabs: [
        Tab(icon: FaIcon(FontAwesomeIcons.book), text: 'Courses'),
        Tab(icon: FaIcon(FontAwesomeIcons.buildingColumns), text: 'Institutes'),
        Tab(icon: FaIcon(FontAwesomeIcons.star), text: 'Ratings'),
      ],
      labelColor: Colors.blue,
      unselectedLabelColor: Colors.grey,
      indicatorColor: Colors.blue,
    );
  }

  Widget _buildCourseList(InstructorModel instructor) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: instructor.coursesTaught?.length ?? 0,
      itemBuilder: (context, index) {
        final course = instructor.coursesTaught![index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: CourseCard(
            course: course,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CourseDetailsScreen(course: course),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
