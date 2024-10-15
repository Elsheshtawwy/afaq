import 'dart:async';
import 'package:afaq/pages/auth/login_screen.dart';
import 'package:afaq/pages/mainScreens/TeachersScreen.dart';
import 'package:afaq/widgets/SearchBar.dart';
import 'package:afaq/widgets/cards/CourseCard.dart';
import 'package:afaq/widgets/cards/TeacherTile.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> searchHints = [
    'Search for courses',
    'Find your next adventure',
    'Explore new skills',
  ];
  int currentHintIndex = 0;
  String currentHintText = '';
  late Timer _timer;
  late Timer _typewriterTimer;
  int _charIndex = 0;
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _startTextChangeTimer();
    _startTypewriterEffect();
  }

  void _startTextChangeTimer() {
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      setState(() {
        currentHintIndex = (currentHintIndex + 1) % searchHints.length;
        _charIndex = 0;
        currentHintText = '';
        _startTypewriterEffect();
      });
    });
  }

  void _startTypewriterEffect() {
    _typewriterTimer =
        Timer.periodic(const Duration(milliseconds: 100), (Timer timer) {
      if (_charIndex < searchHints[currentHintIndex].length) {
        setState(() {
          currentHintText += searchHints[currentHintIndex][_charIndex];
          _charIndex++;
        });
      } else {
        _typewriterTimer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _typewriterTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: _buildAppBar(context),
      drawer: _buildDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomSearchBar(
                hintText: currentHintText,
              ),
              const SizedBox(height: 16),
              _buildBanner(),
              const SizedBox(height: 20),
              _buildMainTitle(context),
              const SizedBox(height: 8),
              _buildSubtitle(),
              const SizedBox(height: 20),
              _buildPopularTeachersSection(context),
              const SizedBox(height: 10),
              _buildPopularTeachersList(),
              _buildMoreCoursesSection(context),
              const SizedBox(height: 10),
              _buildCoursesGrid(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          color: Colors.lightBlue,
        ),
      ),
      elevation: 0,
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      actions: [
        IconButton(
          icon: const FaIcon(FontAwesomeIcons.bell, color: Colors.white),
          onPressed: () {},
        ),
        const Padding(
          padding: EdgeInsets.only(right: 16.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                'https://i.pinimg.com/564x/b0/c7/af/b0c7af6be327de3d7f24ca2ae51eaf46.jpg'),
          ),
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
          _buildDrawerItem(Icons.home, 'Home', context),
          _buildDrawerItem(Icons.search, 'Search', context),
          _buildDrawerItem(Icons.school, 'Courses', context),
          _buildDrawerItem(Icons.person, 'Profile', context),
          _buildDrawerItem(Icons.message, 'Messages', context),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
          ),
        ],
      ),
    );
  }

  ListTile _buildDrawerItem(IconData icon, String title, BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  Widget _buildBannerImage(String imageUrl) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [Colors.black.withOpacity(0.5), Colors.transparent],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.black.withOpacity(0.5),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: const Text(
                'Featured',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBanner() {
    return SizedBox(
      width: double.infinity,
      height: 200,
      child: Swiper(
        autoplay: true,
        autoplayDelay: 6000,
        itemCount: 5,
        itemBuilder: (context, index) {
          return _buildBannerImage(
              'https://wallpapers.com/images/high/machine-gun-kelly-album-cover-rajgn4dxu5kze3no.webp');
        },
        viewportFraction: 0.8,
        scale: 0.9,
        pagination: const SwiperPagination(
          alignment: Alignment.bottomCenter,
          builder: DotSwiperPaginationBuilder(
            color: Colors.grey,
            activeColor: Colors.lightBlue,
            size: 6,
            activeSize: 8,
          ),
        ),
      ),
    );
  }

  Widget _buildMainTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: AutoSizeText(
        "Learn what you need today to succeed tomorrow.",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.lightBlue.shade700,
        ),
        maxLines: 2,
      ),
    );
  }

  Widget _buildSubtitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        "Learning that fits your life today and builds your future.",
        style: TextStyle(color: Colors.grey[600]),
      ),
    );
  }

  Widget _buildPopularTeachersSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Popular teachers",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.lightBlue.shade700),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TeachersScreen()));
            },
            child: Text("see more",
                style: TextStyle(color: Colors.lightBlue.shade700)),
          ),
        ],
      ),
    );
  }

  Widget _buildPopularTeachersList() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          height: 300,
          width: double.infinity,
          child: Swiper(
            itemCount: 6,
            itemBuilder: (context, index) {
              return ListView(
                physics: const BouncingScrollPhysics(),
                children: const [
                  TeacherTile(
                    name: 'Omar Sharif',
                    rating: '4.5',
                    reviews: '13,657',
                    avatarUrl: 'https://via.placeholder.com/50',
                  ),
                  SizedBox(height: 6),
                  TeacherTile(
                    name: 'Ali Omar Sharif',
                    rating: '4.5',
                    reviews: '13,657',
                    avatarUrl: 'https://via.placeholder.com/50',
                  ),
                  SizedBox(height: 6),
                  TeacherTile(
                    name: 'John Doe',
                    rating: '4.5',
                    reviews: '13,657',
                    avatarUrl: 'https://via.placeholder.com/50',
                  ),
                ],
              );
            },
            viewportFraction: constraints.maxWidth > 600 ? 0.5 : 0.9,
            scale: 0.9,
            pagination: const SwiperPagination(
              alignment: Alignment.bottomCenter,
              builder: DotSwiperPaginationBuilder(
                color: Colors.grey,
                activeColor: Colors.lightBlue,
                size: 6,
                activeSize: 8,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMoreCoursesSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Courses",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.lightBlue.shade700),
          ),
          TextButton(
            onPressed: () {},
            child: Text("see more",
                style: TextStyle(color: Colors.lightBlue.shade700)),
          ),
        ],
      ),
    );
  }

  Widget _buildCoursesGrid() {
    final courses = [
      {
        "courseName": "Learn Flutter",
        "price": "429.29",
        "description": "A comprehensive Flutter course",
        "rating": "4.8",
        "reviews": "1500",
      },
      {
        "courseName": "Learn Dart",
        "price": "329.29",
        "description": "A comprehensive Dart course",
        "rating": "4.5",
        "reviews": "1000",
      },
      {
        "courseName": "Learn Firebase",
        "price": "229.29",
        "description": "A comprehensive Firebase course",
        "rating": "4.7",
        "reviews": "1200",
      },
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          height: 330,
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: courses.length,
            itemBuilder: (context, index) {
              final course = courses[index];
              return Container(
                margin: const EdgeInsets.only(left: 16, bottom: 16),
                width: constraints.maxWidth > 600 ? 400 : 300,
                child: CourseCard(
                  courseName: course["courseName"]!,
                  price: course["price"]!,
                  description: course["description"]!,
                  rating: course["rating"]!,
                  reviews: course["reviews"]!,
                  imageUrl:
                      'https://wallpapers.com/images/high/machine-gun-kelly-album-cover-rajgn4dxu5kze3no.webp',
                ),
              );
            },
          ),
        );
      },
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: 'Courses',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.message),
          label: 'Messages',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.lightBlue.shade700,
      unselectedItemColor: Colors.grey.shade600,
      onTap: _onItemTapped,
      selectedFontSize: 14,
      unselectedFontSize: 12,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      elevation: 8,
      showSelectedLabels: true,
      showUnselectedLabels: true,
    );
  }
}
