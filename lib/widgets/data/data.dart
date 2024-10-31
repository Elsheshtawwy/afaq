import 'package:afaq/models/CategoryModel.dart';
import 'package:afaq/models/CourseModel.dart';
import 'package:afaq/models/InstituteModel.dart';
import 'package:afaq/models/InstructorModel.dart';
import 'package:flutter/material.dart';

class dataClass extends StatelessWidget {
  const dataClass({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  List<CategoryModel> getInterests() {
    return [
      // CategoryModel(
      //     id: "0", name: 'Arabic', imageUrl: 'assets/icons/arabic.png'),
      // CategoryModel(
      //     id: "1",
      //     name: 'Artificial Intelligence',
      //     imageUrl: 'assets/icons/artificialintelligence.png'),
      // CategoryModel(
      //     id: "2", name: 'Biology', imageUrl: 'assets/icons/Biology.png'),
      // CategoryModel(
      //     id: "3",
      //     name: 'Business Law',
      //     imageUrl: 'assets/icons/businessLaw.png'),
      // CategoryModel(
      //     id: "4",
      //     name: 'Car Mechanics',
      //     imageUrl: 'assets/icons/carMechanics.png'),
      // CategoryModel(
      //     id: "5", name: 'Chemistry', imageUrl: 'assets/icons/Chemistry.png'),
      // CategoryModel(
      //     id: "6",
      //     name: 'Communication Skills',
      //     imageUrl: 'assets/icons/communicationSkills.png'),
      // CategoryModel(
      //     id: "7",
      //     name: 'Cybersecurity',
      //     imageUrl: 'assets/icons/cybersecurity.png'),
      // CategoryModel(
      //     id: "8",
      //     name: 'Digital Marketing',
      //     imageUrl: 'assets/icons/digitalMarketing.png'),
      // CategoryModel(
      //     id: "9", name: 'English', imageUrl: 'assets/icons/English.png'),
      // CategoryModel(
      //     id: "10",
      //     name: 'Electricity',
      //     imageUrl: 'assets/icons/electricity.png'),
      // CategoryModel(
      //     id: "11", name: 'Fitness', imageUrl: 'assets/icons/fitness.png'),
      // CategoryModel(
      //     id: "12", name: 'German', imageUrl: 'assets/icons/germany.png'),
      // CategoryModel(
      //     id: "13",
      //     name: 'Human Resources',
      //     imageUrl: 'assets/icons/humanResources.png'),
      // CategoryModel(
      //     id: "14",
      //     name: 'Interior Design',
      //     imageUrl: 'assets/icons/interiorDesign.png'),
      // CategoryModel(
      //     id: "15",
      //     name: 'Leadership',
      //     imageUrl: 'assets/icons/leadership.png'),
      // CategoryModel(
      //     id: "16",
      //     name: 'Mathematics',
      //     imageUrl: 'assets/icons/mathematics.png'),
      // CategoryModel(
      //     id: "17", name: 'Nursing', imageUrl: 'assets/icons/nursing.png'),
      // CategoryModel(
      //     id: "18", name: 'Nutrition', imageUrl: 'assets/icons/nutrition.png'),
      // CategoryModel(
      //     id: "19", name: 'Painting', imageUrl: 'assets/icons/painting.png'),
      // CategoryModel(
      //     id: "20",
      //     name: 'Personal Finance',
      //     imageUrl: 'assets/icons/personalFinance.png'),
      // CategoryModel(
      //     id: "21", name: 'Physics', imageUrl: 'assets/icons/Physics.png'),
      // CategoryModel(
      //     id: "22",
      //     name: 'Playing Instruments',
      //     imageUrl: 'assets/icons/playingInstruments.png'),
      // CategoryModel(
      //     id: "23", name: 'Pottery', imageUrl: 'assets/icons/pottery.png'),
      // CategoryModel(
      //     id: "24",
      //     name: 'Programming',
      //     imageUrl: 'assets/icons/programming.png'),
      // CategoryModel(
      //     id: "25",
      //     name: 'Project Management',
      //     imageUrl: 'assets/icons/projectManagement.png'),
      // CategoryModel(
      //     id: "26",
      //     name: 'Time Management',
      //     imageUrl: 'assets/icons/timeManagement.png'),
      // CategoryModel(
      //     id: "28",
      //     name: 'Woodworking',
      //     imageUrl: 'assets/icons/woodworking.png'),
      // CategoryModel(
      //     id: "30",
      //     name: 'Psychology',
      //     imageUrl: 'assets/icons/psychology.png'),
      // CategoryModel(
      //     id: "31",
      //     name: 'Public Speaking',
      //     imageUrl: 'assets/icons/publicSpeaking.png'),
      // CategoryModel(
      //     id: "32", name: 'Robotics', imageUrl: 'assets/icons/robotics.png'),
      // CategoryModel(
      //     id: "33",
      //     name: 'Self-Defense',
      //     imageUrl: 'assets/icons/selfDefense.png'),
      // CategoryModel(
      //     id: "35", name: 'Spanish', imageUrl: 'assets/icons/spanish.png'),
      // CategoryModel(
      //     id: "36",
      //     name: 'Travel and Tourism',
      //     imageUrl: 'assets/icons/travelAndTourism.png'),
      // CategoryModel(
      //     id: "37",
      //     name: 'UX/UI Design',
      //     imageUrl: 'assets/icons/uxuiDesign.png'),
      // CategoryModel(
      //     id: "38",
      //     name: 'Writing Skills',
      //     imageUrl: 'assets/icons/writingSkills.png'),
      
    ];
  }

  List<CourseModel> getCourses() {
    return [
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
        about:
            'This course covers machine learning algorithms and applications.',
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
      CourseModel(
        id: '6',
        title: 'Photography Essentials',
        description:
            'Master the art of photography, from basics to advanced techniques.',
        instructors: [],
        startDate: DateTime(2023, 9, 1),
        endDate: DateTime(2023, 11, 1),
        category: 'Photography',
        subtitle: 'A comprehensive photography course for all levels.',
        price: 180.0,
        oldPrice: 220.0,
        rating: 4.6,
        imageUrl: [
          'https://cdn.photoworkout.com/wp-content/uploads/2021/09/photography-equiment.jpg?w=648&h=432'
        ],
        reviews: 85,
        classes: 12,
        hours: 36,
        about:
            'This course covers photography basics, composition, and lighting.',
        features: ['Practical exercises', 'Field trips'],
        reviewsList: [
          {'review': 'Loved the hands-on approach!'},
          {'review': 'Great for beginners.'},
        ],
        objectives: [
          'Understand photography fundamentals',
          'Learn advanced composition techniques'
        ],
        requirements: ['A digital camera'],
        lessons: ['Camera Basics', 'Lighting Techniques', 'Composition'],
        currentStudents: 30,
        targetStudents: 20,
        level: 'All Levels',
        isOnline: false,
        address: 'Art Center, New York',
        numberOfRatings: 40,
      ),
      CourseModel(
        id: '7',
        title: 'Public Speaking Mastery',
        description:
            'Become a confident public speaker with our specialized training.',
        instructors: [],
        startDate: DateTime(2023, 10, 10),
        endDate: DateTime(2024, 1, 10),
        category: 'Public Speaking',
        subtitle: 'Overcome stage fright and deliver engaging speeches.',
        price: 250.0,
        oldPrice: 300.0,
        rating: 4.8,
        imageUrl: [
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR9RyBQZ5OZW9otachpy8_Ql6BE4lAzjyZW-g&s'
        ],
        reviews: 60,
        classes: 15,
        hours: 45,
        about:
            'Focuses on speech structure, vocal techniques, and body language.',
        features: ['Role-playing', 'Live feedback'],
        reviewsList: [
          {'review': 'I can speak in front of any audience now!'},
          {'review': 'Life-changing skills.'},
        ],
        objectives: [
          'Overcome public speaking fear',
          'Learn to captivate audiences'
        ],
        requirements: ['An open mind and willingness to practice'],
        lessons: ['Speech Crafting', 'Body Language', 'Audience Engagement'],
        currentStudents: 12,
        targetStudents: 15,
        level: 'Intermediate',
        isOnline: true,
        address: 'Online',
        numberOfRatings: 30,
      ),
      CourseModel(
        id: '8',
        title: 'Introduction to Robotics',
        description:
            'Explore robotics concepts, build simple robots, and learn programming.',
        instructors: [],
        startDate: DateTime(2023, 8, 15),
        endDate: DateTime(2023, 10, 15),
        category: 'Robotics',
        subtitle: 'A beginner-friendly robotics course.',
        price: 300.0,
        oldPrice: 400.0,
        rating: 4.7,
        imageUrl: ['https://i.ytimg.com/vi/d_a2KDoJFP0/maxresdefault.jpg'],
        reviews: 120,
        classes: 20,
        hours: 60,
        about: 'Hands-on robotics course for beginners and tech enthusiasts.',
        features: ['Build-your-own robots', 'Coding for robotics'],
        reviewsList: [
          {'review': 'Amazing introduction to robotics!'},
          {'review': 'Learned so much about programming and electronics.'},
        ],
        objectives: ['Build simple robots', 'Program basic robotic movements'],
        requirements: ['Basic math knowledge'],
        lessons: [
          'Introduction to Robotics',
          'Basic Electronics',
          'Coding for Robots'
        ],
        currentStudents: 25,
        targetStudents: 20,
        level: 'Beginner',
        isOnline: true,
        address: 'Tech Innovation Center, San Francisco',
        numberOfRatings: 60,
      ),
      CourseModel(
        id: '9',
        title: 'Cybersecurity Fundamentals',
        description:
            'Learn the basics of cybersecurity and protect digital information.',
        instructors: [],
        startDate: DateTime(2024, 1, 10),
        endDate: DateTime(2024, 3, 10),
        category: 'Cybersecurity',
        subtitle: 'A beginner’s guide to cybersecurity principles.',
        price: 250.0,
        oldPrice: 300.0,
        rating: 4.6,
        imageUrl: [
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRZU_9PRtBLegUYGoN5I7p_pODEdZjoNjgpNg&s'
        ],
        reviews: 200,
        classes: 16,
        hours: 48,
        about:
            'Covers cybersecurity fundamentals, including network security and encryption.',
        features: ['Hands-on labs', 'Industry expert insights'],
        reviewsList: [
          {'review': 'Very informative and up-to-date.'},
          {'review': 'Perfect for beginners in cybersecurity.'},
        ],
        objectives: [
          'Understand cybersecurity basics',
          'Learn data protection methods'
        ],
        requirements: ['Basic IT knowledge'],
        lessons: ['Network Security', 'Cryptography', 'Threat Analysis'],
        currentStudents: 40,
        targetStudents: 30,
        level: 'Beginner',
        isOnline: true,
        address: 'Online',
        numberOfRatings: 90,
      ),
      CourseModel(
        id: '10',
        title: 'Graphic Design Essentials',
        description: 'Master graphic design fundamentals and software tools.',
        instructors: [],
        startDate: DateTime(2024, 2, 5),
        endDate: DateTime(2024, 4, 5),
        category: 'Graphic Design',
        subtitle: 'An introductory course on graphic design.',
        price: 180.0,
        oldPrice: 220.0,
        rating: 4.5,
        imageUrl: [
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREtLoJmv6c_zyeH25zH2i1EuBugrCZE62dMQ&s'
        ],
        reviews: 110,
        classes: 10,
        hours: 30,
        about: 'Includes basics of design principles and popular design tools.',
        features: ['Creative projects', 'Experienced instructors'],
        reviewsList: [
          {'review': 'Loved the creative approach!'},
          {'review': 'Great course for beginners.'},
        ],
        objectives: ['Learn design principles', 'Master graphic design tools'],
        requirements: ['A laptop with design software'],
        lessons: [
          'Introduction to Design',
          'Using Adobe Photoshop',
          'Branding Basics'
        ],
        currentStudents: 20,
        targetStudents: 15,
        level: 'Beginner',
        isOnline: true,
        address: 'Online',
        numberOfRatings: 55,
      ),
      CourseModel(
        id: '11',
        title: 'Artificial Intelligence in Healthcare',
        description: 'Explore AI applications in the healthcare industry.',
        instructors: [],
        startDate: DateTime(2024, 3, 15),
        endDate: DateTime(2024, 6, 15),
        category: 'AI and Healthcare',
        subtitle: 'A specialized course on AI for healthcare professionals.',
        price: 400.0,
        oldPrice: 450.0,
        rating: 4.8,
        imageUrl: [
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRe2QU8ducFlDZnqB4VdDCXtlsmDQSho-rPbw&s'
        ],
        reviews: 150,
        classes: 18,
        hours: 54,
        about: 'Focuses on AI tools and technologies used in healthcare.',
        features: ['Real-world case studies', 'AI implementation labs'],
        reviewsList: [
          {'review': 'Very relevant to the industry.'},
          {'review': 'Excellent for healthcare professionals.'},
        ],
        objectives: [
          'Understand AI in healthcare',
          'Learn machine learning for medical data'
        ],
        requirements: ['Basic AI knowledge'],
        lessons: [
          'AI Basics',
          'Medical Image Analysis',
          'Predictive Analytics'
        ],
        currentStudents: 18,
        targetStudents: 15,
        level: 'Intermediate',
        isOnline: true,
        address: 'Online',
        numberOfRatings: 80,
      ),
      CourseModel(
        id: '12',
        title: 'Elementary English - Level A1',
        description:
            'Build your English language foundation with beginner vocabulary and grammar.',
        instructors: [],
        startDate: DateTime(2024, 1, 5),
        endDate: DateTime(2024, 4, 5),
        category: 'English Language',
        subtitle: 'Basic English course for absolute beginners.',
        price: 150.0,
        oldPrice: 200.0,
        rating: 4.3,
        imageUrl: [
          'https://images.squarespace-cdn.com/content/v1/56d0b039d51cd4e1cdf931e7/1542903926374-U4LEH0LHELQVYF710UA4/Ajouter+un+souA1s-titre.png'
        ],
        reviews: 90,
        classes: 10,
        hours: 20,
        about: 'Focus on basic grammar, vocabulary, and conversation skills.',
        features: ['Interactive activities', 'Grammar basics'],
        reviewsList: [
          {'review': 'Perfect for absolute beginners!'},
          {'review': 'Simple and easy to follow.'},
        ],
        objectives: [
          'Learn basic English vocabulary',
          'Understand simple grammar rules'
        ],
        requirements: ['No prior knowledge required'],
        lessons: [
          'Introduction to English',
          'Basic Grammar',
          'Everyday Vocabulary'
        ],
        currentStudents: 30,
        targetStudents: 25,
        level: 'Elementary',
        isOnline: true,
        address: 'Online',
        numberOfRatings: 45,
      ),
      CourseModel(
        id: '13',
        title: 'Pre-Intermediate - Level A2',
        description:
            'Enhance your English skills by building on basic grammar and vocabulary.',
        instructors: [],
        startDate: DateTime(2024, 2, 15),
        endDate: DateTime(2024, 5, 15),
        category: 'English Language',
        subtitle: 'For learners who have basic knowledge of English.',
        price: 160.0,
        oldPrice: 210.0,
        rating: 4.4,
        imageUrl: [
          'https://happylearningschool.com/images/Pre-Intermediate-English.png'
        ],
        reviews: 100,
        classes: 12,
        hours: 24,
        about: 'Focus on basic conversational skills and sentence structure.',
        features: ['Interactive quizzes', 'Grammar and vocabulary building'],
        reviewsList: [
          {'review': 'Great for building confidence in speaking.'},
          {'review': 'Helpful for A1 learners looking to improve.'},
        ],
        objectives: [
          'Understand basic sentences',
          'Engage in simple conversations'
        ],
        requirements: ['Completion of A1 level or basic English knowledge'],
        lessons: [
          'Simple Conversations',
          'Basic Sentence Structure',
          'Everyday Expressions'
        ],
        currentStudents: 25,
        targetStudents: 20,
        level: 'Pre-Intermediate',
        isOnline: true,
        address: 'Online',
        numberOfRatings: 55,
      ),
      CourseModel(
        id: '14',
        title: 'Intermediate English - Level B1',
        description:
            'Develop conversational fluency and comprehension for everyday interactions.',
        instructors: [],
        startDate: DateTime(2024, 3, 10),
        endDate: DateTime(2024, 6, 10),
        category: 'English Language',
        subtitle: 'For learners ready to speak more confidently in English.',
        price: 200.0,
        oldPrice: 250.0,
        rating: 4.6,
        imageUrl: [
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR9-jrr2JGH9tVgcNGEUUk_iffagfWserTiDg&s'
        ],
        reviews: 140,
        classes: 15,
        hours: 30,
        about:
            'Improves grammar, vocabulary, and everyday conversation skills.',
        features: ['Role-playing exercises', 'Group discussions'],
        reviewsList: [
          {'review': 'Loved the interactive approach!'},
          {'review': 'Perfect for gaining confidence in speaking.'},
        ],
        objectives: ['Fluency in everyday topics', 'Understand spoken English'],
        requirements: ['Completion of A2 level'],
        lessons: [
          'Conversational English',
          'Listening Practice',
          'Reading Comprehension'
        ],
        currentStudents: 35,
        targetStudents: 30,
        level: 'Intermediate',
        isOnline: true,
        address: 'Online',
        numberOfRatings: 70,
      ),
      CourseModel(
        id: '15',
        title: 'Upper-Intermediate - Level B2',
        description:
            'Achieve a higher level of fluency and learn complex grammatical structures.',
        instructors: [],
        startDate: DateTime(2024, 4, 20),
        endDate: DateTime(2024, 7, 20),
        category: 'English Language',
        subtitle:
            'For learners aiming to understand and communicate complex ideas.',
        price: 220.0,
        oldPrice: 280.0,
        rating: 4.7,
        imageUrl: [
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSGWpJLmaJ3W4z1fOEP58JDmIDKuZjI8OHINg&s'
        ],
        reviews: 160,
        classes: 18,
        hours: 36,
        about: 'Explores complex grammar and advanced vocabulary.',
        features: [
          'Advanced conversation practice',
          'Comprehensive grammar drills'
        ],
        reviewsList: [
          {'review': 'Excellent course with a lot of depth.'},
          {'review': 'Really helped with complex sentences.'},
        ],
        objectives: [
          'Discuss complex topics',
          'Use complex grammar structures'
        ],
        requirements: ['Completion of B1 level'],
        lessons: [
          'Advanced Grammar',
          'Complex Conversations',
          'Writing Practice'
        ],
        currentStudents: 40,
        targetStudents: 35,
        level: 'Upper-Intermediate',
        isOnline: true,
        address: 'Online',
        numberOfRatings: 85,
      ),
      CourseModel(
        id: '16',
        title: 'Advanced English - Level C1',
        description:
            'Master advanced English language skills and achieve full fluency.',
        instructors: [],
        startDate: DateTime(2024, 5, 15),
        endDate: DateTime(2024, 8, 15),
        category: 'English Language',
        subtitle: 'For those looking to achieve near-native proficiency.',
        price: 250.0,
        oldPrice: 300.0,
        rating: 4.8,
        imageUrl: [
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQL6yhrvuXqxBEGUX5FEVY3hTV2rbT5CqzW-w&s'
        ],
        reviews: 180,
        classes: 20,
        hours: 40,
        about:
            'Covers advanced speaking, listening, reading, and writing skills.',
        features: ['High-level vocabulary', 'Advanced listening exercises'],
        reviewsList: [
          {'review': 'A must for advanced learners!'},
          {'review': 'Challenging and rewarding.'},
        ],
        objectives: ['Master fluency', 'Understand and use idioms'],
        requirements: ['Completion of B2 level'],
        lessons: [
          'Advanced Conversations',
          'Idiomatic Expressions',
          'Academic Writing'
        ],
        currentStudents: 45,
        targetStudents: 40,
        level: 'Advanced',
        isOnline: true,
        address: 'Online',
        numberOfRatings: 90,
      ),
      CourseModel(
        id: '17',
        title: 'Proficiency English - Level C2',
        description:
            'Achieve near-native proficiency and prepare for English proficiency exams.',
        instructors: [],
        startDate: DateTime(2024, 6, 20),
        endDate: DateTime(2024, 9, 20),
        category: 'English Language',
        subtitle:
            'For advanced learners aiming for complete fluency and precision.',
        price: 300.0,
        oldPrice: 350.0,
        rating: 4.9,
        imageUrl: [
          'https://abaqschool.com/wp-content/uploads/2021/03/playlist-3.png'
        ],
        reviews: 200,
        classes: 22,
        hours: 44,
        about:
            'Prepares for professional and academic use of English at a native level.',
        features: ['Exam preparation', 'Professional English writing'],
        reviewsList: [
          {'review': 'Perfect preparation for the CPE exam.'},
          {'review': 'Really enhanced my academic writing skills.'},
        ],
        objectives: [
          'Achieve proficiency',
          'Prepare for English certification exams'
        ],
        requirements: ['Completion of C1 level'],
        lessons: ['Professional Writing', 'Public Speaking', 'Exam Techniques'],
        currentStudents: 50,
        targetStudents: 45,
        level: 'Proficiency',
        isOnline: true,
        address: 'Online',
        numberOfRatings: 95,
      ),
    ];
  }

  List<InstructorModel> getInstructors() {
    return [
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
        experiences: [
          'Worked at XYZ University',
          'Published 5 research papers'
        ],
        jobTitle: 'Computer Science',
      ),
      InstructorModel(
        id: '2',
        name: 'Mr.Badr',
        email: 'john.doe@example.com',
        phoneNumber: '123-456-7891',
        profilePicture:
            'https://www.lta.org.uk/4915f7/siteassets/in-your-area/iom---county-coaching.jpg?w=1200+',
        institutes: [],
        coursesTaught: [],
        qualifications: ['MSc in Computer Science'],
        bio: 'John Doe is an experienced instructor in computer science.',
        experienceYears: 5,
        gender: 'Male',
        experiences: ['Worked at ABC University'],
        jobTitle: 'Computer Science',
      ),
      InstructorModel(
        id: '4',
        name: 'Layla Al-Najjar',
        email: 'layla.alnajjar@example.com',
        phoneNumber: '123-456-7893',
        jobTitle: 'Chemistry',
        profilePicture:
            'https://www.lta.org.uk/4915f7/siteassets/in-your-area/iom---county-coaching.jpg?w=1200',
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
  }

  List<InstituteModel> getInstitutes() {
    return [
      InstituteModel(
        id: '1',
        name: 'Libyan International Medical University',
        address: 'Benghazi, Libya',
        contactNumbers: ['+218 61-222-2222'],
        email: 'info@limu.edu.ly',
        logoUrl: 'https://uli.rcu.gov.sa/media/wh5dhgbq/image.jpg',
        accreditation: 'Libyan Ministry of Higher Education',
        bio:
            'The Libyan International Medical University is a private university in Benghazi, Libya, founded in 2007.',
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
        accreditation: 'Libyan Ministry of Higher Education',
        bio:
            'The University of Tripoli is the largest and oldest university in Libya, established in 1957.',
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
        accreditation: 'Libyan Ministry of Higher Education',
        bio:
            'Misurata University is a public university located in Misurata, Libya, founded in 1984.',
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
        accreditation: 'Libyan Ministry of Higher Education',
        bio:
            'The University of Benghazi, formerly known as Garyounis University, is one of the largest public universities in Libya.',
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
        accreditation: 'Libyan Ministry of Higher Education',
        bio:
            'Sirte University is a public university located in Sirte, Libya, and offers a variety of programs in multiple disciplines.',
        courses: [],
      ),
    ];
  }
}
