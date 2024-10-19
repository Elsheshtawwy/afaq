import 'package:afaq/models/CategoryModel.dart';
import 'package:afaq/models/CourseModel.dart';
import 'package:afaq/models/InstituteModel.dart';
import 'package:afaq/models/InstructorModel.dart';
import 'package:afaq/pages/Onboarding/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  List<CourseModel> courses = [];
  List<InstructorModel> instructors = [];
  List<InstituteModel> institutes = [];
  List<CategoryModel> categories = [];

  runApp(MyApp(
    courses: courses,
    instructors: instructors,
    institutes: institutes,
    categories: categories,
  ));
}

class MyApp extends StatelessWidget {
  final List<CourseModel> courses;
  final List<InstructorModel> instructors;
  final List<InstituteModel> institutes;
  final List<CategoryModel> categories;

  const MyApp(
      {super.key,
      required this.courses,
      required this.instructors,
      required this.institutes,
      required this.categories});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Afaq',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF5F9FF),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF5F9FF),
          elevation: 0,
        ),
        primaryColor: const Color(0xFF4667FD),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4667FD)),
        useMaterial3: true,
      ),
      home: SplashScreen(
        courses: courses,
        instructors: instructors,
        institutes: institutes,
        categories: categories,
      ),
    );
  }
}
