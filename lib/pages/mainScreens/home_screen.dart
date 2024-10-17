import 'package:afaq/pages/auth/login_screen.dart';
import 'package:afaq/pages/mainScreens/categoriesScreen.dart';
import 'package:afaq/pages/mainScreens/popularCourses.dart';
import 'package:afaq/pages/mainScreens/topMentor.dart';
import 'package:afaq/widgets/SearchBar.dart';
import 'package:afaq/widgets/cards/CourseCardHome.dart';
import 'package:afaq/widgets/categoryFilters.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
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
                        builder: (context) => CategoriesScreen()));
              }),
              const SizedBox(height: 10),
              _buildCategories(),
              const SizedBox(height: 20),
              _buildSectionHeader('Popular Courses', () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PopularCourses()));
              }),
              CategoryFilters(),
              const SizedBox(height: 8),
              _buildPopularCourses(isLargeScreen),
              const SizedBox(height: 20),
              _buildSectionHeader('Top Mentor', () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TopMentorScreen()));
              }),
              const SizedBox(height: 8),
              _buildTopMentors(),
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
            backgroundImage: NetworkImage('https://via.placeholder.com/150'),
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
              Navigator.pop(context);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
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

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: const Row(
          children: [
            Icon(Icons.search, color: Colors.grey),
            SizedBox(width: 8),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search for...',
                  border: InputBorder.none,
                ),
              ),
            ),
            Icon(Icons.filter_list, color: Colors.blue),
          ],
        ),
      ),
    );
  }

  Widget _buildSwiper() {
    return SizedBox(
      height: 200,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
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
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        scrollDirection: Axis.horizontal,
        children: [
          _buildCategoryChip('All', Colors.blue, () {}),
          _buildCategoryChip('3D Design', Colors.grey, () {}),
          _buildCategoryChip('Arts & Humanities', Colors.grey, () {}),
          _buildCategoryChip('Graphic Design', Colors.grey, () {}),
          _buildCategoryChip('Programming', Colors.grey, () {}),
          _buildCategoryChip('Marketing', Colors.grey, () {}),
        ],
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

  Widget _buildPopularCourses(bool isLargeScreen) {
    return SizedBox(
      height: 270,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        scrollDirection: Axis.horizontal,
        children: [
          CourseCardHome(
            title: 'Graphic Design Advanced',
            subtitle: 'Level Up Your Skills',
            price: '\$28',
            rating: 4.2,
            students: 7830,
            imageUrl: 'https://via.placeholder.com/150',
            bgColor: Colors.teal[50]!,
            width: isLargeScreen ? 300 : 270,
          ),
          CourseCardHome(
            title: 'Advertisement Design',
            subtitle: 'Creative Ad Mastery',
            price: '\$42',
            rating: 4.8,
            students: 5890,
            imageUrl: 'https://via.placeholder.com/150',
            bgColor: Colors.pink[50]!,
            width: isLargeScreen ? 300 : 270,
          ),
          CourseCardHome(
            title: 'UI/UX Design',
            subtitle: 'From Basics to Pro',
            price: '\$35',
            rating: 4.5,
            students: 9500,
            imageUrl: 'https://via.placeholder.com/150',
            bgColor: Colors.blue[50]!,
            width: isLargeScreen ? 300 : 270,
          ),
        ],
      ),
    );
  }

  Widget _buildTopMentors() {
    return SizedBox(
      height: 150,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        scrollDirection: Axis.horizontal,
        children: const [
          MentorAvatar(
            name: 'Sonja',
            avatarUrl:
                'https://www.nmspacemuseum.org/wp-content/uploads/2019/03/Elon_Musk.jpg',
          ),
          MentorAvatar(
            name: 'Jensen',
            avatarUrl:
                'https://www.nmspacemuseum.org/wp-content/uploads/2019/03/Elon_Musk.jpg',
          ),
          MentorAvatar(
            name: 'Victoria',
            avatarUrl:
                'https://www.nmspacemuseum.org/wp-content/uploads/2019/03/Elon_Musk.jpg',
          ),
          MentorAvatar(
            name: 'Castaldo',
            avatarUrl:
                'https://www.nmspacemuseum.org/wp-content/uploads/2019/03/Elon_Musk.jpg',
          ),
        ],
      ),
    );
  }
}

class MentorAvatar extends StatelessWidget {
  final String name;
  final String avatarUrl;

  const MentorAvatar({super.key, required this.name, required this.avatarUrl});

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
                image: NetworkImage(avatarUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
          const Text('Top Mentor',
              style: TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }
}
