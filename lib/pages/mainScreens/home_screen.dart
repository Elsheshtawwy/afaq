import 'package:afaq/models/CourseModel.dart';
import 'package:afaq/pages/auth/login_screen.dart';
import 'package:afaq/pages/mainScreens/InstitutesScreen.dart';
import 'package:afaq/pages/mainScreens/categoriesScreen.dart';
import 'package:afaq/pages/mainScreens/CoursesScreen.dart';
import 'package:afaq/pages/mainScreens/InstructorScreen.dart';
import 'package:afaq/widgets/SearchBar.dart';
import 'package:afaq/widgets/cards/CourseCardHome.dart';
import 'package:afaq/widgets/cards/instituteCardHome.dart';
import 'package:afaq/widgets/cards/mentorAvatar.dart';
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
                        builder: (context) => CategoriesScreen()));
              }),
              const SizedBox(height: 10),
              _buildCategories(),
              const SizedBox(height: 20),
              _buildSectionHeader('Popular Courses', () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CoursesScreen(
                              courses: [
                                CourseModel(
                                  id: "1",
                                  title: 'Graphic Design Advanced',
                                  rating: 4.2,
                                  reviews: 7830,
                                  price: 28,
                                  oldPrice: 42,
                                  classes: 12,
                                  hours: 26,
                                  imageUrl: 'https://via.placeholder.com/150',
                                  instructor: 'John Doe',
                                  instructorImage:
                                      'https://via.placeholder.com/150',
                                  description:
                                      'This course covers advanced topics in graphic design, including typography, color theory, and branding. It is suitable for intermediate designers who want to take their skills to the next level.',
                                  objectives: [
                                    'Understand advanced concepts in graphic design',
                                    'Create professional branding materials',
                                    'Develop a portfolio of advanced design projects',
                                  ],
                                  requirements: [
                                    'Basic knowledge of graphic design software',
                                    'Access to design tools and software',
                                  ],
                                  lessons: [
                                    'Introduction to Advanced Graphic Design',
                                    'Typography and Layout Design',
                                    'Color Theory and Branding',
                                    'Advanced Design Projects',
                                  ],
                                  features: [
                                    '12 Classes',
                                    '26 Hours of Content',
                                    'Certificate of Completion',
                                    'Expert Instructor',
                                  ],
                                  reviewsList: [
                                    {
                                      'name': 'Alice',
                                      'review': 'Great course, learned a lot!',
                                    },
                                    {
                                      'name': 'Bob',
                                      'review': 'Instructor was very helpful.',
                                    },
                                  ],
                                  startDate: DateTime.now(),
                                  endDate:
                                      DateTime.now().add(Duration(days: 30)),
                                  subtitle: 'Advanced Techniques',
                                  about:
                                      'Learn advanced graphic design techniques.',
                                  instructorName: 'John Doe',
                                  category: 'Graphic Design',
                                  students: 7830,
                                ),
                                CourseModel(
                                  id: "2",
                                  title: 'Advertisement Design',
                                  rating: 4.8,
                                  reviews: 5890,
                                  price: 42,
                                  oldPrice: 50,
                                  classes: 10,
                                  hours: 20,
                                  imageUrl: 'https://via.placeholder.com/150',
                                  instructor: 'Jane Smith',
                                  instructorImage:
                                      'https://via.placeholder.com/150',
                                  description:
                                      'Master the art of advertisement design with this comprehensive course. Learn how to create compelling ads that capture attention and drive results.',
                                  objectives: [
                                    'Understand the principles of advertisement design',
                                    'Create effective ad campaigns',
                                    'Develop a portfolio of advertisement projects',
                                  ],
                                  requirements: [
                                    'Basic knowledge of design software',
                                    'Access to design tools and software',
                                  ],
                                  lessons: [
                                    'Introduction to Advertisement Design',
                                    'Creating Compelling Ads',
                                    'Ad Campaign Strategies',
                                    'Advanced Advertisement Projects',
                                  ],
                                  features: [
                                    '10 Classes',
                                    '20 Hours of Content',
                                    'Certificate of Completion',
                                    'Expert Instructor',
                                  ],
                                  reviewsList: [
                                    {
                                      'name': 'Charlie',
                                      'review': 'Very informative course!',
                                    },
                                    {
                                      'name': 'Dana',
                                      'review': 'Loved the practical examples.',
                                    },
                                  ],
                                  startDate: DateTime.now(),
                                  endDate:
                                      DateTime.now().add(Duration(days: 30)),
                                  subtitle: 'Creative Ad Mastery',
                                  about:
                                      'Learn to create compelling advertisements.',
                                  instructorName: 'Jane Smith',
                                  category: 'Advertisement Design',
                                  students: 5890,
                                ),
                                CourseModel(
                                  id: "3",
                                  title: 'UI/UX Design',
                                  rating: 4.5,
                                  reviews: 9500,
                                  price: 35,
                                  oldPrice: 45,
                                  classes: 15,
                                  hours: 30,
                                  imageUrl: 'https://via.placeholder.com/150',
                                  instructor: 'Michael Brown',
                                  instructorImage:
                                      'https://via.placeholder.com/150',
                                  description:
                                      'This course takes you from the basics to advanced concepts in UI/UX design. Learn how to create user-friendly interfaces and enhance user experiences.',
                                  objectives: [
                                    'Understand UI/UX design principles',
                                    'Create user-friendly interfaces',
                                    'Develop a portfolio of UI/UX projects',
                                  ],
                                  requirements: [
                                    'Basic knowledge of design software',
                                    'Access to design tools and software',
                                  ],
                                  lessons: [
                                    'Introduction to UI/UX Design',
                                    'User Research and Analysis',
                                    'Wireframing and Prototyping',
                                    'Advanced UI/UX Projects',
                                  ],
                                  features: [
                                    '15 Classes',
                                    '30 Hours of Content',
                                    'Certificate of Completion',
                                    'Expert Instructor',
                                  ],
                                  reviewsList: [
                                    {
                                      'name': 'Eve',
                                      'review': 'Excellent course on UI/UX!',
                                    },
                                    {
                                      'name': 'Frank',
                                      'review': 'Highly recommend this course.',
                                    },
                                  ],
                                  startDate: DateTime.now(),
                                  endDate:
                                      DateTime.now().add(Duration(days: 30)),
                                  subtitle: 'From Basics to Pro',
                                  about:
                                      'Learn UI/UX design from basics to advanced.',
                                  instructorName: 'Michael Brown',
                                  category: 'UI/UX Design',
                                  students: 9500,
                                ),
                                CourseModel(
                                  id: "4",
                                  title: 'Web Development',
                                  rating: 4.7,
                                  reviews: 12000,
                                  price: 50,
                                  oldPrice: 60,
                                  classes: 20,
                                  hours: 40,
                                  imageUrl: 'https://via.placeholder.com/150',
                                  instructor: 'Emily Davis',
                                  instructorImage:
                                      'https://via.placeholder.com/150',
                                  description:
                                      'Learn web development from scratch. This course covers HTML, CSS, JavaScript, and more. Build your own websites and web applications.',
                                  objectives: [
                                    'Understand web development fundamentals',
                                    'Create responsive websites',
                                    'Develop a portfolio of web projects',
                                  ],
                                  requirements: [
                                    'Basic knowledge of programming',
                                    'Access to a computer and internet',
                                  ],
                                  lessons: [
                                    'Introduction to Web Development',
                                    'HTML and CSS Basics',
                                    'JavaScript and DOM Manipulation',
                                    'Advanced Web Projects',
                                  ],
                                  features: [
                                    '20 Classes',
                                    '40 Hours of Content',
                                    'Certificate of Completion',
                                    'Expert Instructor',
                                  ],
                                  reviewsList: [
                                    {
                                      'name': 'Grace',
                                      'review':
                                          'Fantastic web development course!',
                                    },
                                    {
                                      'name': 'Henry',
                                      'review':
                                          'Learned a lot, highly recommend.',
                                    },
                                  ],
                                  startDate: DateTime.now(),
                                  endDate:
                                      DateTime.now().add(Duration(days: 30)),
                                  subtitle: 'Full Stack Development',
                                  about: 'Learn full stack web development.',
                                  instructorName: 'Emily Davis',
                                  category: 'Web Development',
                                  students: 12000,
                                ),
                                CourseModel(
                                  id: "5",
                                  title: 'Digital Marketing',
                                  rating: 4.6,
                                  reviews: 8500,
                                  price: 40,
                                  oldPrice: 50,
                                  classes: 18,
                                  hours: 35,
                                  imageUrl: 'https://via.placeholder.com/150',
                                  instructor: 'David Wilson',
                                  instructorImage:
                                      'https://via.placeholder.com/150',
                                  description:
                                      'Master digital marketing strategies with this comprehensive course. Learn SEO, social media marketing, email marketing, and more.',
                                  objectives: [
                                    'Understand digital marketing fundamentals',
                                    'Create effective marketing campaigns',
                                    'Develop a portfolio of marketing projects',
                                  ],
                                  requirements: [
                                    'Basic knowledge of marketing',
                                    'Access to a computer and internet',
                                  ],
                                  lessons: [
                                    'Introduction to Digital Marketing',
                                    'SEO and SEM Basics',
                                    'Social Media Marketing',
                                    'Advanced Marketing Projects',
                                  ],
                                  features: [
                                    '18 Classes',
                                    '35 Hours of Content',
                                    'Certificate of Completion',
                                    'Expert Instructor',
                                  ],
                                  reviewsList: [
                                    {
                                      'name': 'Ivy',
                                      'review':
                                          'Great insights into digital marketing!',
                                    },
                                    {
                                      'name': 'Jack',
                                      'review':
                                          'Very practical and useful course.',
                                    },
                                  ],
                                  startDate: DateTime.now(),
                                  endDate:
                                      DateTime.now().add(Duration(days: 30)),
                                  subtitle: 'Marketing Mastery',
                                  about: 'Learn digital marketing strategies.',
                                  instructorName: 'David Wilson',
                                  category: 'Digital Marketing',
                                  students: 8500,
                                ),
                                CourseModel(
                                  id: "6",
                                  title: 'Data Science',
                                  rating: 4.9,
                                  reviews: 15000,
                                  price: 60,
                                  oldPrice: 75,
                                  classes: 25,
                                  hours: 50,
                                  imageUrl: 'https://via.placeholder.com/150',
                                  instructor: 'Sophia Martinez',
                                  instructorImage:
                                      'https://via.placeholder.com/150',
                                  description:
                                      'Become a data science expert with this in-depth course. Learn data analysis, machine learning, and data visualization techniques.',
                                  objectives: [
                                    'Understand data science principles',
                                    'Analyze and visualize data',
                                    'Develop a portfolio of data science projects',
                                  ],
                                  requirements: [
                                    'Basic knowledge of programming',
                                    'Access to a computer and internet',
                                  ],
                                  lessons: [
                                    'Introduction to Data Science',
                                    'Data Analysis with Python',
                                    'Machine Learning Basics',
                                    'Advanced Data Science Projects',
                                  ],
                                  features: [
                                    '25 Classes',
                                    '50 Hours of Content',
                                    'Certificate of Completion',
                                    'Expert Instructor',
                                  ],
                                  reviewsList: [
                                    {
                                      'name': 'Liam',
                                      'review':
                                          'Best data science course out there!',
                                    },
                                    {
                                      'name': 'Mia',
                                      'review':
                                          'Learned so much, highly recommend.',
                                    },
                                  ],
                                  startDate: DateTime.now(),
                                  endDate:
                                      DateTime.now().add(Duration(days: 30)),
                                  subtitle: 'Data Science Mastery',
                                  about: 'Learn data science from scratch.',
                                  instructorName: 'Sophia Martinez',
                                  category: 'Data Science',
                                  students: 15000,
                                ),
                              ],
                            )));
              }),
              CategoryFilters(),
              const SizedBox(height: 8),
              _buildPopularCourses(isLargeScreen),
              const SizedBox(height: 20),
              _buildSectionHeader('Top Instructors', () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const InstructorScreen()));
              }),
              const SizedBox(height: 8),
              _buildTopMentors(),
              const SizedBox(height: 20),
              _buildSectionHeader('Popular Institutes', () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return InstitutesScreen();
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
      height: 230,
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
            imageUrl:
                'https://www.daily.co/blog/content/images/size/w2000/2023/07/Flutter-feature.png',
            bgColor: Colors.teal[50]!,
            width: isLargeScreen ? 300 : 270,
          ),
          CourseCardHome(
            title: 'Advertisement Design',
            subtitle: 'Creative Ad Mastery',
            price: '\$42',
            rating: 4.8,
            students: 5890,
            imageUrl:
                'https://www.daily.co/blog/content/images/size/w2000/2023/07/Flutter-feature.png',
            bgColor: Colors.pink[50]!,
            width: isLargeScreen ? 300 : 270,
          ),
          CourseCardHome(
            title: 'UI/UX Design',
            subtitle: 'From Basics to Pro',
            price: '\$35',
            rating: 4.5,
            students: 9500,
            imageUrl:
                'https://www.daily.co/blog/content/images/size/w2000/2023/07/Flutter-feature.png',
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

  Widget _buildInstitutes() {
    return SizedBox(
      height: 280,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        scrollDirection: Axis.horizontal,
        children: [
          InstituteCardHome(
            name: 'Institute A',
            imageUrl: 'assets/InstituteImage.jpg',
            location: 'Location A',
            rating: '4.5',
            description: 'A leading institute offering a variety of courses.',
          ),
          InstituteCardHome(
            name: 'Institute B',
            imageUrl: 'assets/InstituteImage.jpg',
            location: 'Location B',
            rating: '4.0',
            description: 'Known for its excellent faculty and infrastructure.',
          ),
          InstituteCardHome(
            name: 'Institute C',
            imageUrl: 'assets/InstituteImage.jpg',
            location: 'Location C',
            rating: '4.8',
            description:
                'Offers specialized courses in technology and science.',
          ),
          InstituteCardHome(
            name: 'Institute D',
            imageUrl: 'assets/InstituteImage.jpg',
            location: 'Location D',
            rating: '4.2',
            description: 'Renowned for its arts and humanities programs.',
          ),
          InstituteCardHome(
            name: 'Institute E',
            imageUrl: 'assets/InstituteImage.jpg',
            location: 'Location E',
            rating: '4.7',
            description: 'Top choice for business and management studies.',
          ),
          InstituteCardHome(
            name: 'Institute F',
            imageUrl: 'assets/InstituteImage.jpg',
            location: 'Location F',
            rating: '4.3',
            description: 'Offers a wide range of engineering courses.',
          ),
          InstituteCardHome(
            name: 'Institute G',
            imageUrl: 'assets/InstituteImage.jpg',
            location: 'Location G',
            rating: '4.6',
            description: 'Known for its innovative teaching methods.',
          ),
          InstituteCardHome(
            name: 'Institute H',
            imageUrl: 'assets/InstituteImage.jpg',
            location: 'Location H',
            rating: '4.1',
            description:
                'Provides excellent support for international students.',
          ),
          InstituteCardHome(
            name: 'Institute I',
            imageUrl: 'assets/InstituteImage.jpg',
            location: 'Location I',
            rating: '4.9',
            description: 'Highly rated for its research facilities.',
          ),
          InstituteCardHome(
            name: 'Institute J',
            imageUrl: 'assets/InstituteImage.jpg',
            location: 'Location J',
            rating: '4.4',
            description: 'Offers a variety of online and offline courses.',
          ),
          InstituteCardHome(
            name: 'Institute K',
            imageUrl: 'assets/InstituteImage.jpg',
            location: 'Location K',
            rating: '4.0',
            description: 'Known for its strong alumni network.',
          ),
          InstituteCardHome(
            name: 'Institute L',
            imageUrl: 'assets/InstituteImage.jpg',
            location: 'Location L',
            rating: '4.5',
            description: 'Provides excellent career counseling services.',
          ),
          InstituteCardHome(
            name: 'Institute M',
            imageUrl: 'assets/InstituteImage.jpg',
            location: 'Location M',
            rating: '4.2',
            description: 'Offers scholarships for deserving students.',
          ),
          InstituteCardHome(
            name: 'Institute N',
            imageUrl: 'assets/InstituteImage.jpg',
            location: 'Location N',
            rating: '4.7',
            description: 'Known for its vibrant campus life.',
          ),
        ],
      ),
    );
  }
}
