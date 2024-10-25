import 'package:afaq/models/CategoryModel.dart';
import 'package:afaq/models/CourseModel.dart';
import 'package:afaq/models/InstituteModel.dart';
import 'package:afaq/models/InstructorModel.dart';
import 'package:afaq/pages/auth/login_screen.dart';
import 'package:afaq/pages/mainScreens/CourseDetailsPage.dart';
import 'package:afaq/pages/mainScreens/InstitutesDetailsScreen.dart';
import 'package:afaq/pages/mainScreens/InstitutesScreen.dart';
import 'package:afaq/pages/mainScreens/InstructorDetailsScreen.dart';
import 'package:afaq/pages/mainScreens/UserInfoScreen.dart';
import 'package:afaq/pages/mainScreens/categoriesScreen.dart';
import 'package:afaq/pages/mainScreens/CoursesScreen.dart';
import 'package:afaq/pages/mainScreens/InstructorScreen.dart';
import 'package:afaq/providers/auth_provider.dart';
import 'package:afaq/widgets/SearchBar.dart';
import 'package:afaq/widgets/cards/CourseCardHome.dart';
import 'package:afaq/widgets/cards/instituteCardHome.dart';
import 'package:afaq/widgets/cards/likedCourses.dart';
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
  final List<CategoryModel> categories = [
    CategoryModel(id: "0", name: 'Arabic', imageUrl: 'assets/icons/arabic.png'),
    CategoryModel(
        id: "1",
        name: 'Artificial Intelligence',
        imageUrl: 'assets/icons/artificialintelligence.png'),
    CategoryModel(
        id: "2", name: 'Biology', imageUrl: 'assets/icons/Biology.png'),
    CategoryModel(
        id: "3",
        name: 'Business Law',
        imageUrl: 'assets/icons/businessLaw.png'),
    CategoryModel(
        id: "4",
        name: 'Car Mechanics',
        imageUrl: 'assets/icons/carMechanics.png'),
    CategoryModel(
        id: "5", name: 'Chemistry', imageUrl: 'assets/icons/Chemistry.png'),
    CategoryModel(
        id: "6",
        name: 'Communication Skills',
        imageUrl: 'assets/icons/communicationSkills.png'),
    CategoryModel(
        id: "7",
        name: 'Cybersecurity',
        imageUrl: 'assets/icons/cybersecurity.png'),
    CategoryModel(
        id: "8",
        name: 'Digital Marketing',
        imageUrl: 'assets/icons/digitalMarketing.png'),
    CategoryModel(
        id: "9", name: 'English', imageUrl: 'assets/icons/English.png'),
    CategoryModel(
        id: "10",
        name: 'Electricity',
        imageUrl: 'assets/icons/electricity.png'),
    CategoryModel(
        id: "11", name: 'Fitness', imageUrl: 'assets/icons/fitness.png'),
    CategoryModel(
        id: "12", name: 'German', imageUrl: 'assets/icons/germany.png'),
    CategoryModel(
        id: "13",
        name: 'Human Resources',
        imageUrl: 'assets/icons/humanResources.png'),
    CategoryModel(
        id: "14",
        name: 'Interior Design',
        imageUrl: 'assets/icons/interiorDesign.png'),
    CategoryModel(
        id: "15", name: 'Leadership', imageUrl: 'assets/icons/leadership.png'),
    CategoryModel(
        id: "16",
        name: 'Mathematics',
        imageUrl: 'assets/icons/mathematics.png'),
    CategoryModel(
        id: "17", name: 'Nursing', imageUrl: 'assets/icons/nursing.png'),
    CategoryModel(
        id: "18", name: 'Nutrition', imageUrl: 'assets/icons/nutrition.png'),
    CategoryModel(
        id: "19", name: 'Painting', imageUrl: 'assets/icons/painting.png'),
    CategoryModel(
        id: "20",
        name: 'Personal Finance',
        imageUrl: 'assets/icons/personalFinance.png'),
    CategoryModel(
        id: "21", name: 'Physics', imageUrl: 'assets/icons/Physics.png'),
    CategoryModel(
        id: "22",
        name: 'Playing Instruments',
        imageUrl: 'assets/icons/playingInstruments.png'),
    CategoryModel(
        id: "23", name: 'Pottery', imageUrl: 'assets/icons/pottery.png'),
    CategoryModel(
        id: "24",
        name: 'Programming',
        imageUrl: 'assets/icons/programming.png'),
    CategoryModel(
        id: "25",
        name: 'Project Management',
        imageUrl: 'assets/icons/projectManagement.png'),
    CategoryModel(
        id: "26",
        name: 'Time Management',
        imageUrl: 'assets/icons/timeManagement.png'),
    CategoryModel(
        id: "27",
        name: 'Web Development',
        imageUrl: 'assets/icons/webDevelopment.png'),
    CategoryModel(
        id: "28",
        name: 'Woodworking',
        imageUrl: 'assets/icons/woodworking.png'),
  ];

  final List<CourseModel> courses = [
    CourseModel(
      id: '1',
      title: 'Introduction to Programming',
      description: 'Learn the basics of programming using Python.',
      instructors: [],
      startDate: DateTime(2023, 10, 1),
      endDate: DateTime(2023, 12, 1),
      category: 'Programming',
      subtitle: 'A beginner-friendly course on programming.',
      price: 100.0,
      oldPrice: 150.0,
      rating: 4.5,
      imageUrl: [
        'https://johnthecomputerman.co.uk/storage/2021/05/introtoprogramming-190909184629-thumbnail-4.jpg',
        "https://modo3.com/thumbs/fit630x300/258361/1691981178/%D8%A3%D8%B3%D8%A7%D8%B3%D9%8A%D8%A7%D8%AA_%D8%AA%D8%B9%D9%84%D9%85_%D8%A7%D9%84%D9%84%D8%BA%D8%A9_%D8%A7%D9%84%D8%A5%D9%86%D8%AC%D9%84%D9%8A%D8%B2%D9%8A%D8%A9.jpg",
        'https://johnthecomputerman.co.uk/storage/2021/05/introtoprogramming-190909184629-thumbnail-4.jpg',
        "https://modo3.com/thumbs/fit630x300/258361/1691981178/%D8%A3%D8%B3%D8%A7%D8%B3%D9%8A%D8%A7%D8%AA_%D8%AA%D8%B9%D9%84%D9%85_%D8%A7%D9%84%D9%84%D8%BA%D8%A9_%D8%A7%D9%84%D8%A5%D9%86%D8%AC%D9%84%D9%8A%D8%B2%D9%8A%D8%A9.jpg",
        'https://johnthecomputerman.co.uk/storage/2021/05/introtoprogramming-190909184629-thumbnail-4.jpg',
      ],
      reviews: 120,
      classes: 10,
      hours: 30,
      about: 'This course covers the fundamentals of programming.',
      features: ['Hands-on projects', 'Expert instructors'],
      reviewsList: [
        {'review': 'Great course!'},
        {'review': 'Very informative.'},
      ],
      objectives: ['Understand programming basics', 'Write simple programs'],
      requirements: ['No prior experience needed'],
      lessons: ['Introduction', 'Variables', 'Control Structures'],
      currentStudents: 20,
      targetStudents: 5,
      level: 'Beginner',
      isOnline: true,
      address: 'Online',
      numberOfRatings: 50,
    ),
    CourseModel(
      id: '2',
      title: 'Learn English',
      description:
          'Improve your English language skills with this comprehensive course.',
      instructors: [],
      startDate: DateTime(2023, 11, 1),
      endDate: DateTime(2024, 1, 1),
      category: 'English',
      subtitle: 'A complete course on English language learning.',
      price: 200.0,
      oldPrice: 250.0,
      rating: 4.8,
      imageUrl: [
        "https://modo3.com/thumbs/fit630x300/258361/1691981178/%D8%A3%D8%B3%D8%A7%D8%B3%D9%8A%D8%A7%D8%AA_%D8%AA%D8%B9%D9%84%D9%85_%D8%A7%D9%84%D9%84%D8%BA%D8%A9_%D8%A7%D9%84%D8%A5%D9%86%D8%AC%D9%84%D9%8A%D8%B2%D9%8A%D8%A9.jpg"
      ],
      reviews: 150,
      classes: 15,
      hours: 45,
      about: 'This course covers all aspects of English language learning.',
      features: ['Interactive lessons', 'Experienced instructors'],
      reviewsList: [
        {'review': 'Excellent course!'},
        {'review': 'Highly recommended.'},
      ],
      objectives: [
        'Improve English grammar',
        'Enhance vocabulary and pronunciation'
      ],
      requirements: ['Basic English knowledge'],
      lessons: ['Grammar', 'Vocabulary', 'Pronunciation'],
      currentStudents: 15,
      targetStudents: 10,
      level: 'Intermediate',
      isOnline: true,
      address: 'Online',
      numberOfRatings: 75,
    ),
    CourseModel(
      id: '3',
      title: 'Data Science with Python',
      description: 'Learn data science concepts and techniques using Python.',
      instructors: [],
      startDate: DateTime(2023, 12, 1),
      endDate: DateTime(2024, 2, 1),
      category: 'Data Science',
      subtitle: 'A comprehensive course on data science with Python.',
      price: 300.0,
      oldPrice: 350.0,
      rating: 4.7,
      imageUrl: [
        'https://www.mygreatlearning.com/blog/wp-content/uploads/2019/09/What-is-data-science-2.jpg'
      ],
      reviews: 200,
      classes: 20,
      hours: 60,
      about: 'This course covers data science techniques and tools.',
      features: ['Hands-on projects', 'Industry experts'],
      reviewsList: [
        {'review': 'Very informative and practical.'},
        {'review': 'Great for data science enthusiasts.'},
      ],
      objectives: [
        'Understand data science concepts',
        'Apply data science techniques'
      ],
      requirements: ['Basic programming knowledge'],
      lessons: ['Data Analysis', 'Machine Learning', 'Data Visualization'],
      currentStudents: 18,
      targetStudents: 15,
      level: 'Intermediate',
      isOnline: true,
      address: 'Online',
      numberOfRatings: 100,
    ),
    CourseModel(
      id: '4',
      title: 'Web Development Bootcamp',
      description:
          'Become a full-stack web developer with this comprehensive bootcamp.',
      instructors: [],
      startDate: DateTime(2023, 10, 15),
      endDate: DateTime(2024, 1, 15),
      category: 'Web Development',
      subtitle: 'A complete bootcamp on web development.',
      price: 400.0,
      oldPrice: 450.0,
      rating: 4.9,
      imageUrl: [
        'https://camo.githubusercontent.com/db746ba4bb5946ea2c6646e6b758f9c036f59385449c92e02cdf63f0200429c8/68747470733a2f2f7777772e63726561746976656974696e737469747574652e636f6d2f696d616765732f636f757273652f636f757273655f313636333035323035362e6a7067',
        'https://miro.medium.com/v2/resize:fit:1200/1*V-Jp13LvtVc2IiY2fp4qYw.jpeg',
      ],
      reviews: 250,
      classes: 25,
      hours: 75,
      about:
          'This bootcamp covers both front-end and back-end web development.',
      features: ['Project-based learning', 'Career support'],
      reviewsList: [
        {'review': 'Best bootcamp ever!'},
        {'review': 'Learned so much.'},
      ],
      objectives: [
        'Build full-stack web applications',
        'Understand web development frameworks'
      ],
      requirements: ['Basic HTML and CSS knowledge'],
      lessons: ['HTML & CSS', 'JavaScript', 'React', 'Node.js'],
      currentStudents: 22,
      targetStudents: 20,
      level: 'All Levels',
      isOnline: true,
      address: 'Online',
      numberOfRatings: 125,
    ),
    CourseModel(
      id: '5',
      title: 'Machine Learning with Python',
      description:
          'Master machine learning concepts and techniques using Python.',
      instructors: [],
      startDate: DateTime(2023, 11, 15),
      endDate: DateTime(2024, 2, 15),
      category: 'Machine Learning',
      subtitle: 'An in-depth course on machine learning.',
      price: 350.0,
      oldPrice: 400.0,
      rating: 4.6,
      imageUrl: [
        "https://d3lkc3n5th01x7.cloudfront.net/wp-content/uploads/2023/11/07002655/Machine-Learning-Services-banner.png"
      ],
      reviews: 180,
      classes: 18,
      hours: 54,
      about: 'This course covers machine learning algorithms and applications.',
      features: ['Hands-on projects', 'Expert instructors'],
      reviewsList: [
        {'review': 'Very detailed and practical.'},
        {'review': 'Great for learning ML.'},
      ],
      objectives: [
        'Understand machine learning algorithms',
        'Apply ML techniques to real-world problems'
      ],
      requirements: ['Basic Python knowledge'],
      lessons: [
        'Supervised Learning',
        'Unsupervised Learning',
        'Neural Networks'
      ],
      currentStudents: 16,
      targetStudents: 12,
      level: 'Intermediate',
      isOnline: true,
      address: 'Online',
      numberOfRatings: 90,
    ),
  ];

  final List<InstructorModel> instructors = [
    InstructorModel(
      id: '1',
      name: 'Ahmed Al-Farsi',
      email: 'ahmed.alfarsi@example.com',
      phoneNumber: '123-456-7890',
      profilePicture:
          'https://www.uned.es/universidad/.imaging/mte/home-nueva-theme/761x691/dam/recursos-corporativos/personas-genericas/profesores-(2).jpg/jcr:content/profesores-(2).jpg',
      institutes: [],
      coursesTaught: [
        CourseModel(
            id: '1',
            title: 'Introduction to Programming',
            description: 'Learn the basics of programming using Python.',
            instructors: [],
            startDate: DateTime(2023, 10, 1),
            endDate: DateTime(2023, 12, 1),
            category: 'Programming',
            subtitle: 'A beginner-friendly course on programming.',
            price: 100.0,
            oldPrice: 150.0,
            rating: 4.5,
            imageUrl: [
              'https://johnthecomputerman.co.uk/storage/2021/05/introtoprogramming-190909184629-thumbnail-4.jpg',
              "https://modo3.com/thumbs/fit630x300/258361/1691981178/%D8%A3%D8%B3%D8%A7%D8%B3%D9%8A%D8%A7%D8%AA_%D8%AA%D8%B9%D9%84%D9%85_%D8%A7%D9%84%D9%84%D8%BA%D8%A9_%D8%A7%D9%84%D8%A5%D9%86%D8%AC%D9%84%D9%8A%D8%B2%D9%8A%D8%A9.jpg",
              'https://johnthecomputerman.co.uk/storage/2021/05/introtoprogramming-190909184629-thumbnail-4.jpg',
              'https://modo3.com/thumbs/fit630x300/258361/1691981178/%D8%A3%D8%B3%D8%A7%D8%B3%D9%8A%D8%A7%D8%AA_%D8%AA%D8%B9%D9%84%D9%85_%D8%A7%D9%84%D9%84%D8%BA%D8%A9_%D8%A7%D9%84%D8%A5%D9%86%D8%AC%D9%84%D9%8A%D8%B2%D9%8A%D8%A9.jpg',
              'https://johnthecomputerman.co.uk/storage/2021/05/introtoprogramming-190909184629-thumbnail-4.jpg',
            ],
            reviews: 120,
            classes: 10,
            hours: 30,
            about: 'This course covers the fundamentals of programming.')
      ],
      qualifications: ['PhD in Computer Science', 'MSc in Data Science'],
      bio:
          'Dr. Ahmed Al-Farsi is an experienced instructor in programming and data science.',
      experienceYears: 10,
      gender: 'Male',
      experiences: ['Worked at XYZ University', 'Published 5 research papers'],
      jobTitle: 'Computer Science',
    ),
    InstructorModel(
      id: '2',
      name: 'Fatima Al-Mansouri',
      email: 'fatima.almansouri@example.com',
      phoneNumber: '123-456-7891',
      jobTitle: 'Mathematics',
      profilePicture:
          'https://www.uned.es/universidad/.imaging/mte/home-nueva-theme/761x691/dam/recursos-corporativos/personas-genericas/profesores-(2).jpg/jcr:content/profesores-(2).jpg',
      institutes: [],
    ),
    InstructorModel(
      id: '3',
      name: 'Hassan Al-Haddad',
      email: 'hassan.alhaddad@example.com',
      phoneNumber: '123-456-7892',
      jobTitle: 'Physics',
      profilePicture:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ1TYP78ZMERVzy0ubkh42BY0jTYFKCklKa_pn2F538eYBhv0k3Xos6FI6VSGwpslYOerQ&usqp=CAU',
      institutes: [],
    ),
    InstructorModel(
      id: '4',
      name: 'Layla Al-Najjar',
      email: 'layla.alnajjar@example.com',
      phoneNumber: '123-456-7893',
      jobTitle: 'Chemistry',
      profilePicture:
          'https://www.uned.es/universidad/.imaging/mte/home-nueva-theme/761x691/dam/recursos-corporativos/personas-genericas/profesores-(2).jpg/jcr:content/profesores-(2).jpg',
      institutes: [],
    ),
    InstructorModel(
      id: '5',
      name: 'Mohammed Al-Salem',
      email: 'mohammed.alsalem@example.com',
      phoneNumber: '123-456-7894',
      jobTitle: 'Biology',
      profilePicture:
          'https://www.iwcf.org/wp-content/uploads/2018/12/Instructor-top-of-page-image-new.jpg',
      institutes: [],
    ),
    InstructorModel(
      id: '6',
      name: 'Noura Al-Harbi',
      email: 'noura.alharbi@example.com',
      phoneNumber: '123-456-7895',
      jobTitle: 'Business Law',
      profilePicture:
          'https://www.lta.org.uk/4915f7/siteassets/in-your-area/iom---county-coaching.jpg?w=1200',
      institutes: [],
    ),
    InstructorModel(
      id: '7',
      name: 'Omar Al-Khalifa',
      email: 'omar.alkhalifa@example.com',
      phoneNumber: '123-456-7896',
      jobTitle: 'Cybersecurity',
      profilePicture:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ1TYP78ZMERVzy0ubkh42BY0jTYFKCklKa_pn2F538eYBhv0k3Xos6FI6VSGwpslYOerQ&usqp=CAU',
      institutes: [],
    ),
    InstructorModel(
      id: '8',
      name: 'Sara Al-Rashid',
      email: 'sara.alrashid@example.com',
      phoneNumber: '123-456-7897',
      jobTitle: 'Digital Marketing',
      profilePicture:
          'https://www.ascm.org/globalassets/ascm_website_assets/img/2-5-how-do-i-apply-block.jpg',
      institutes: [],
    ),
    InstructorModel(
      id: '9',
      name: 'Yousef Al-Zahrani',
      email: 'yousef.alzahrani@example.com',
      phoneNumber: '123-456-7898',
      jobTitle: 'English',
      profilePicture:
          'https://www.uned.es/universidad/.imaging/mte/home-nueva-theme/761x691/dam/recursos-corporativos/personas-genericas/profesores-(2).jpg/jcr:content/profesores-(2).jpg',
      institutes: [],
    ),
    InstructorModel(
      id: '10',
      name: 'Zainab Al-Shehri',
      email: 'zainab.alshehri@example.com',
      phoneNumber: '123-456-7899',
      jobTitle: 'Leadership',
      profilePicture:
          'https://www.iwcf.org/wp-content/uploads/2018/12/Instructor-top-of-page-image-new.jpg',
      institutes: [],
    ),
  ];
  final List<InstituteModel> institutes = [
    InstituteModel(
      id: '1',
      name: 'Libyan International Medical University',
      address: 'Benghazi, Libya',
      contactNumbers: ['+218 61-222-2222'],
      email: 'info@limu.edu.ly',
      logoUrl: 'https://uli.rcu.gov.sa/media/wh5dhgbq/image.jpg',
      rating: 4.5,
      reviews: ["200"],
      accreditation: 'Libyan Ministry of Higher Education',
      bio:
          'The Libyan International Medical University is a private university in Benghazi, Libya, founded in 2007.',
      instructors: [],
      courses: [],
    ),
    InstituteModel(
      id: '2',
      name: 'University of Tripoli',
      address: 'Tripoli, Libya',
      contactNumbers: ['+218 21-462-8866'],
      email: 'info@uot.edu.ly',
      logoUrl:
          'https://www.kesan.org/wp-content/uploads/2019/03/%D8%AC%D9%8A-%D8%A7%D9%94%D9%8A-%D8%A7%D9%88-%D8%A7%D8%B3-%D9%84%D9%84%D8%BA%D8%A7%D8%AA-%D8%A7%D9%84%D8%A7%D9%94%D8%AC%D9%86%D8%A8%D9%8A%D8%A9-%D9%83%D8%A7%D9%84%D9%8A%D9%81%D9%88%D8%B1%D9%86%D9%8A%D8%A7.jpg',
      rating: 4.7,
      reviews: ["200"],
      accreditation: 'Libyan Ministry of Higher Education',
      bio:
          'The University of Tripoli is the largest and oldest university in Libya, established in 1957.',
      instructors: [],
      courses: [],
    ),
    InstituteModel(
      id: '3',
      name: 'Misurata University',
      address: 'Misurata, Libya',
      contactNumbers: ['+218 51-261-0000'],
      email: 'info@mu.edu.ly',
      logoUrl:
          'https://elmahrousanews.com/wp-content/uploads/2021/09/%D8%A7%D9%84%D9%85%D8%B9%D9%87%D8%AF-%D8%A7%D9%84%D8%B9%D8%A7%D9%84%D9%89-%D9%84%D9%84%D8%BA%D8%A7%D8%AA-%D8%A8%D9%85%D8%B5%D8%B1-%D8%A7%D9%84%D8%AC%D8%AF%D9%8A%D8%AF%D8%A9-1-300x199.jpg',
      rating: 4.6,
      reviews: ["200"],
      accreditation: 'Libyan Ministry of Higher Education',
      bio:
          'Misurata University is a public university located in Misurata, Libya, founded in 1984.',
      instructors: [],
      courses: [],
    ),
    InstituteModel(
      id: '4',
      name: 'University of Benghazi',
      address: 'Benghazi, Libya',
      contactNumbers: ['+218 61-223-4567'],
      email: 'info@uob.edu.ly',
      logoUrl:
          'https://www.kesan.org/wp-content/uploads/2019/03/%D8%AC%D9%8A-%D8%A7%D9%94%D9%8A-%D8%A7%D9%88-%D8%A7%D8%B3-%D9%84%D9%84%D8%BA%D8%A7%D8%AA-%D8%A7%D9%84%D8%A7%D9%94%D8%AC%D9%86%D8%A8%D9%8A%D8%A9-%D9%83%D8%A7%D9%84%D9%8A%D9%81%D9%88%D8%B1%D9%86%D9%8A%D8%A7.jpg',
      rating: 4.6,
      reviews: ["200"],
      accreditation: 'Libyan Ministry of Higher Education',
      bio:
          'The University of Benghazi, formerly known as Garyounis University, is one of the largest public universities in Libya.',
      instructors: [],
      courses: [],
    ),
    InstituteModel(
      id: '5',
      name: 'Sirte University',
      address: 'Sirte, Libya',
      contactNumbers: ['+218 54-555-0000'],
      email: 'info@sirte.edu.ly',
      logoUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTvyqmugSqEBoM8caXHE14ep76yiBmMPZaMMQ&s',
      rating: 4.4,
      reviews: ["200"],
      accreditation: 'Libyan Ministry of Higher Education',
      bio:
          'Sirte University is a public university located in Sirte, Libya, and offers a variety of programs in multiple disciplines.',
      instructors: [],
      courses: [],
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

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
          icon: CircleAvatar(
            backgroundImage: NetworkImage(
              FirebaseAuth.instance.currentUser!.photoURL ??
                  'https://static.vecteezy.com/system/resources/thumbnails/002/318/271/small_2x/user-profile-icon-free-vector.jpg',
            ),
            onBackgroundImageError: (_, __) {
              setState(() {});
            },
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const UserEditInfoScreen(),
              ),
            );
          },
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
          _buildDrawerItem(Icons.book, 'Liked Courses'),
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
                MaterialPageRoute(builder: (context) => const LoginScreen()),
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
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LikedCoursesScreen(
                  userId: FirebaseAuth.instance.currentUser?.uid ?? '',
                  instructors: instructors)),
        );
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
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length, // عدد الفئات
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
}
