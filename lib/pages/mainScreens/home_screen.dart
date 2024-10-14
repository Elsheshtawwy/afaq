import 'dart:async';

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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchBar(),
              const SizedBox(height: 16),
              _buildBanner(),
              const SizedBox(height: 20),
              _buildMainTitle(context),
              const SizedBox(height: 8),
              _buildSubtitle(),
              const SizedBox(height: 20),
              _buildTopCoursesSection(context),
              const SizedBox(height: 10),
              _buildCourseList(),
              const SizedBox(height: 20),
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

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          FaIcon(FontAwesomeIcons.search, color: Colors.lightBlue.shade700),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: currentHintText,
                border: InputBorder.none,
              ),
            ),
          ),
          FaIcon(FontAwesomeIcons.filter, color: Colors.lightBlue.shade700),
        ],
      ),
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
        itemCount: 5,
        itemBuilder: (context, index) {
          return _buildBannerImage(
              'https://wallpapers.com/images/high/machine-gun-kelly-album-cover-rajgn4dxu5kze3no.webp');
        },
        viewportFraction: 0.8,
        scale: 0.9,
      ),
    );
  }

  Widget _buildMainTitle(BuildContext context) {
    return AutoSizeText(
      "Learn what you need today to succeed tomorrow.",
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.lightBlue.shade700,
      ),
      maxLines: 2,
    );
  }

  Widget _buildSubtitle() {
    return Text(
      "Learning that fits your life today and builds your future.",
      style: TextStyle(color: Colors.grey[600]),
    );
  }

  Widget _buildTopCoursesSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Top courses",
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
    );
  }

  Widget _buildCourseList() {
    return const Column(
      children: [
        CourseTile(
            name: 'Omar Shareef',
            rating: '4.5',
            reviews: '13,657',
            avatarUrl: 'https://via.placeholder.com/50'),
        SizedBox(height: 10),
        CourseTile(
            name: 'Ali Omar Sharif',
            rating: '4.5',
            reviews: '13,657',
            avatarUrl: 'https://via.placeholder.com/50'),
      ],
    );
  }

  Widget _buildMoreCoursesSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "More courses",
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
    );
  }

  Widget _buildCoursesGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 0.75,
      children: const [
        CourseCard(courseName: "Learn Flutter", price: "429.29"),
        CourseCard(courseName: "Learn JS", price: "429.29"),
        CourseCard(courseName: "Learn Python", price: "429.29"),
        CourseCard(courseName: "Learn English", price: "429.29"),
      ],
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.lightBlue.shade700,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Courses'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Messages'),
      ],
    );
  }
}

class CourseTile extends StatefulWidget {
  final String name;
  final String rating;
  final String reviews;
  final String avatarUrl;

  const CourseTile({
    super.key,
    required this.name,
    required this.rating,
    required this.reviews,
    required this.avatarUrl,
  });

  @override
  _CourseTileState createState() => _CourseTileState();
}

class _CourseTileState extends State<CourseTile> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(widget.avatarUrl),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                widget.name,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                maxLines: 1,
              ),
              Row(
                children: [
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(Icons.star,
                          color: Colors.yellow[700], size: 16);
                    }),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "${widget.rating} (${widget.reviews})",
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            icon: FaIcon(
              isFavorite ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
              color: isFavorite ? Colors.red : Colors.lightBlue.shade700,
            ),
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
              });
            },
          ),
        ],
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  final String courseName;
  final String price;

  const CourseCard({
    super.key,
    required this.courseName,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.network('https://via.placeholder.com/100',
                fit: BoxFit.cover),
          ),
          const SizedBox(height: 10),
          AutoSizeText(
            courseName,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            maxLines: 1,
          ),
          const SizedBox(height: 4),
          Text(
            "₺ $price",
            style: TextStyle(
              color: Colors.grey[700],
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
