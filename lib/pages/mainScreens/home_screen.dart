import 'package:afaq/models/CategoryModel.dart';
import 'package:afaq/models/CourseModel.dart';
import 'package:afaq/models/InstituteModel.dart';
import 'package:afaq/models/InstructorModel.dart';
import 'package:afaq/pages/auth/login_screen.dart';
import 'package:afaq/pages/mainScreens/CourseDetailsPage.dart';
import 'package:afaq/pages/mainScreens/InstitutesScreen.dart';
import 'package:afaq/pages/mainScreens/categoriesScreen.dart';
import 'package:afaq/pages/mainScreens/CoursesScreen.dart';
import 'package:afaq/pages/mainScreens/InstructorScreen.dart';
import 'package:afaq/providers/auth_provider.dart';
import 'package:afaq/widgets/SearchBar.dart';
import 'package:afaq/widgets/cards/CourseCardHome.dart';
import 'package:afaq/widgets/cards/instituteCardHome.dart';
import 'package:afaq/widgets/cards/mentorAvatar.dart';
import 'package:afaq/widgets/categoryFilters.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<CategoryModel> categories = [];
  final List<CourseModel> courses = [];
  final List<InstructorModel> instructors = [];
  final List<InstituteModel> institutes = [];
  String _selectedCategory = '';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 600;

    return Scaffold(
      appBar: _buildAppBar(),
      drawer: _buildDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: CustomSearchBar(
                  hintText: 'Search for',
                ),
              ),
              const SizedBox(height: 20),
              _buildSwiper(),
              const SizedBox(height: 20),
              _buildSectionHeader('Categories', () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CategoriesScreen(categories: categories)));
              }),
              const SizedBox(height: 10),
              _buildCategories(),
              const SizedBox(height: 20),
              _buildSectionHeader('Popular Courses', () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CoursesScreen(
                            courses: courses, instructors: instructors)));
              }),
              const CategoryFilters(),
              const SizedBox(height: 8),
              _buildPopularCourses(isLargeScreen, courses),
              const SizedBox(height: 20),
              _buildSectionHeader('Top Instructors', () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            InstructorScreen(instructors: instructors)));
              }),
              const SizedBox(height: 8),
              _buildTopMentors(),
              const SizedBox(height: 20),
              _buildSectionHeader('Popular Institutes', () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return InstitutesScreen(Institutes: institutes);
                }));
              }),
              const SizedBox(height: 8),
              _buildInstitutes(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu, color: Color(0xff167F71)),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      title: const Text(
        'AFAQ',
        style: TextStyle(color: Color(0xff167F71), fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          iconSize: 40,
          padding: const EdgeInsets.all(0),
          icon: const ImageIcon(
            AssetImage("assets/notifiction.png"),
            color: Color(0xff167F71),
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: const CircleAvatar(
            backgroundImage: NetworkImage(
                'https://www.daily.co/blog/content/images/2023/07/Flutter-feature.png'),
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  Drawer _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.lightBlue.shade100,
                  Colors.lightBlue.shade300,
                  Colors.lightBlue.shade700,
                ],
                stops: const [0.1, 0.5, 0.9],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
            child: const Text(
              'Menu',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ),
          _buildDrawerItem(Icons.home, 'Home'),
          _buildDrawerItem(Icons.search, 'Search'),
          _buildDrawerItem(Icons.school, 'Courses'),
          _buildDrawerItem(Icons.person, 'Profile'),
          _buildDrawerItem(Icons.message, 'Messages'),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              GoogleSignIn().signOut();
              final authProvider =
                  Provider.of<Auth_Provider>(context, listen: false);
              authProvider.logout(context);
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
    );
  }

  ListTile _buildDrawerItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  Widget _buildSwiper() {
    return SizedBox(
      height: 200,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: _buildSwiperItem(),
          );
        },
        itemCount: 3,
        autoplay: true,
        pagination: const SwiperPagination(
          builder: DotSwiperPaginationBuilder(
            color: Colors.white70,
            activeColor: Colors.white,
            size: 8.0,
            activeSize: 10.0,
          ),
        ),
      ),
    );
  }

  Widget _buildSwiperItem() {
    return Container(
      height: 220,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '25% OFF*',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Today’s Special',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Get a discount for every course order only valid for today!',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, VoidCallback onSeeAllPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              TextButton(
                onPressed: onSeeAllPressed,
                child: const Text('SEE ALL',
                    style: TextStyle(
                      color: Color(0xff0961F5),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Color(0xff0961F5),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    final categories = [
      {'name': 'All', 'color': Colors.blue},
      {'name': '3D Design', 'color': Colors.grey},
      {'name': 'Arts & Humanities', 'color': Colors.grey},
      {'name': 'Graphic Design', 'color': Colors.grey},
      {'name': 'Programming', 'color': Colors.grey},
      {'name': 'Marketing', 'color': Colors.grey},
    ];

    return SizedBox(
      height: 40,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length, // عدد الفئات
        itemBuilder: (context, index) {
          return _buildCategoryChip(
            categories[index]['name'] as String,
            categories[index]['color'] as Color,
            () {
              // يمكنك هنا إضافة حدث للنقر لكل فئة
            },
          );
        },
      ),
    );
  }

  Widget _buildCategoryChip(String label, Color color, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedCategory = label;
          });
          onTap();
        },
        child: Text(
          label,
          style: TextStyle(
            color: _selectedCategory == label ||
                    _selectedCategory == '' && label == 'All'
                ? Colors.blue
                : Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildPopularCourses(bool isLargeScreen, List<CourseModel> courses) {
    return SizedBox(
      height: 230,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        scrollDirection: Axis.horizontal,
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CourseDetailsScreen(
                    course: course,
                    instructors: instructors,
                  ),
                ),
              );
            },
            child: CourseCardHome(
              course: course,
              bgColor: Colors.white,
            ),
          );
        },
      ),
    );
  }

  Widget _buildTopMentors() {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        scrollDirection: Axis.horizontal,
        itemCount: instructors.length,
        itemBuilder: (context, index) {
          return MentorAvatar(
            instructor: instructors[index],
          );
        },
      ),
    );
  }

  Widget _buildInstitutes() {
    return SizedBox(
      height: 280,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        scrollDirection: Axis.horizontal,
        itemCount: institutes.length,
        itemBuilder: (context, index) {
          return InstituteCardHome(
            institute: institutes[index],
          );
        },
      ),
    );
  }
}
