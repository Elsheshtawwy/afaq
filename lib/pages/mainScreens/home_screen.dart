import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        decoration: BoxDecoration(
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
      title: const Text(
        "Search your teacher",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      actions: [
        IconButton(
          icon: const FaIcon(FontAwesomeIcons.bell, color: Colors.white),
          onPressed: () {},
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage('https://via.placeholder.com/150'),
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
                stops: [0.1, 0.5, 0.9],
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
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.search),
            title: const Text('Search'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.school),
            title: const Text('Courses'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.message),
            title: const Text('Messages'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
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
    return Container(
      width: double.infinity,
      height: 200,
      child: PageView.builder(
        controller: PageController(viewportFraction: 0.8),
        itemCount: 3,
        itemBuilder: (context, index) {
          return _buildBannerImage('https://via.placeholder.com/350');
        },
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
                  Icon(Icons.star, color: Colors.yellow[700], size: 16),
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
