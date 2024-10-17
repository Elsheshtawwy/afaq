import 'package:afaq/pages/Onboarding/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      home: const SplashScreen(),
    );
  }
}
