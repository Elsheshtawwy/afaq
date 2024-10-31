import 'package:afaq/models/CategoryModel.dart';
import 'package:afaq/models/CourseModel.dart';
import 'package:afaq/models/InstituteModel.dart';
import 'package:afaq/models/InstructorModel.dart';
import 'package:afaq/pages/Onboarding/onboardingScreen.dart';
import 'package:afaq/pages/auth/login_screen.dart';
import 'package:afaq/pages/DetailsScreens.dart/CourseDetailsPage.dart';
import 'package:afaq/pages/mainScreens/AddCourseScreen.dart';
import 'package:afaq/pages/mainScreens/MyProfile.dart';
import 'package:afaq/pages/DetailsScreens.dart/InstitutesDetailsScreen.dart';
import 'package:afaq/pages/mainScreens/InstitutesScreen.dart';
import 'package:afaq/pages/DetailsScreens.dart/InstructorDetailsScreen.dart';
import 'package:afaq/pages/mainScreens/categoriesScreen.dart';
import 'package:afaq/pages/mainScreens/CoursesScreen.dart';
import 'package:afaq/pages/mainScreens/InstructorScreen.dart';
import 'package:afaq/providers/auth_provider.dart';
import 'package:afaq/providers/dark_mode_provider.dart';
import 'package:afaq/providers/user_data_provider.dart';
import 'package:afaq/widgets/SearchBar.dart';
import 'package:afaq/widgets/cards/CourseCardHome.dart';
import 'package:afaq/widgets/cards/instituteCardHome.dart';
import 'package:afaq/widgets/cards/likedCourses.dart';
import 'package:afaq/widgets/cards/mentorAvatar.dart';
import 'package:afaq/widgets/categoryFilters.dart';
import 'package:afaq/widgets/data/data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  final List<CategoryModel> categories = dataClass().getInterests();
  final List<CourseModel> courses = dataClass().getCourses();
  final List<InstructorModel> instructors = dataClass().getInstructors();
  final List<InstituteModel> institutes = dataClass().getInstitutes();
  

  @override
  void initState() {
    super.initState();
    UserDataProvider()
        .getProfilePicture(FirebaseAuth.instance.currentUser?.uid ?? '');
        
    return;
  }

  String _selectedCategory = '';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 600;

    return Consumer<UserDataProvider>(builder: (context, userDataProvider, _) {
      return Scaffold(
        floatingActionButton: _FloatingActionButton(),
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
                    return InstitutesScreen(institutes: institutes);
                  }));
                }),
                const SizedBox(height: 8),
                _buildInstitutes(),
              ],
            ),
          ),
        ),
      );
    });
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      title: const Text(
        'AFAQ',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      actions: [
        Row(
          children: [
            IconButton(
              iconSize: 40,
              padding: const EdgeInsets.all(0),
              icon: const ImageIcon(
                AssetImage("assets/notifiction.png"),
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            IconButton(
              padding: const EdgeInsets.all(0),
              icon: const ProfilePicture(
                size: 40,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyProfile(),
                  ),
                );
              },
            ),
            const SizedBox(
              width: 8,
            ),
          ],
        ),
      ],
    );
  }

  Consumer<DarkModeProvider> _buildDrawer() {
    return Consumer<DarkModeProvider>(
        builder: (context, darkModeProvider, child) {
      return Drawer(
        backgroundColor:
            darkModeProvider.isDark ? Colors.grey[900] : Colors.white,
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
            _buildDrawerItem(Icons.book, 'Liked Courses'),
            const Divider(),
            ListTile(
              leading: Icon(Icons.logout,
                  color: darkModeProvider.isDark ? Colors.white : Colors.black),
              title: Text('Logout',
                  style: TextStyle(
                      color: darkModeProvider.isDark
                          ? Colors.white
                          : Colors.black)),
              onTap: () {
                GoogleSignIn().signOut();
                final authProvider =
                    Provider.of<Auth_Provider>(context, listen: false);
                authProvider.logout(context);
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            ),
          ],
        ),
      );
    });
  }

  Consumer<DarkModeProvider> _buildDrawerItem(IconData icon, String title) {
    return Consumer<DarkModeProvider>(
        builder: (context, darkModeProvider, child) {
      return ListTile(
        leading: Icon(icon,
            color: darkModeProvider.isDark ? Colors.white : Colors.black),
        title: Text(title,
            style: TextStyle(
                color: darkModeProvider.isDark ? Colors.white : Colors.black)),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LikedCoursesScreen(
                    userId: FirebaseAuth.instance.currentUser?.uid ?? '',
                    instructors: instructors)),
          );
        },
      );
    });
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
    return SizedBox(
      height: 40,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return _buildCategoryChip(
            categories[index].name,
            Colors.blue,
            () {},
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
      height: 250,
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
      height: 160,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        scrollDirection: Axis.horizontal,
        itemCount: instructors.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InstructorDetailsScreen(
                    instructor: instructors[index],
                  ),
                ),
              );
            },
            child: MentorAvatar(
              instructor: instructors[index],
            ),
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
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InstitutesDetailsScreen(
                    institute: institutes[index],
                  ),
                ),
              );
            },
            child: InstituteCardHome(
              institute: institutes[index],
            ),
          );
        },
      ),
    );
  }

  Widget _FloatingActionButton() {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('institutes')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox.shrink();
        }
        if (snapshot.hasError) {
          return const SizedBox.shrink();
        }
        if (snapshot.hasData && snapshot.data?.data() != null) {
          var userData = snapshot.data?.data() as Map<String, dynamic>;
          if (userData['userType'] == 'Institute') {
            return FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddCourseScreen(),
                  ),
                );
              },
              child: const Icon(Icons.add),
            );
          }
        }
        return const SizedBox.shrink();
      },
    );
  }
}
