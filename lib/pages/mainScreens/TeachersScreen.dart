import 'dart:async';
import 'package:afaq/widgets/SearchBar.dart';
import 'package:afaq/widgets/cards/TeacherTile.dart';
import 'package:flutter/material.dart';

class TeachersScreen extends StatefulWidget {
  const TeachersScreen({super.key});

  @override
  _TeachersScreenState createState() => _TeachersScreenState();
}

class _TeachersScreenState extends State<TeachersScreen> {
  int _selectedIndex = 0;

  List<String> searchHints = [
    'Search for teachers',
    'Find the best tutors',
    'Explore top educators',
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Find a Private Teacher',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            CustomSearchBar(
              hintText: currentHintText,
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Top Teachers',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView(
                  children: const [
                    TeacherTile(
                      name: 'Omar Sharif',
                      rating: '4.5',
                      reviews: '13,657',
                      avatarUrl: 'https://via.placeholder.com/50',
                    ),
                    SizedBox(height: 10),
                    TeacherTile(
                      name: 'Ali Omar Sharif',
                      rating: '4.5',
                      reviews: '13,657',
                      avatarUrl: 'https://via.placeholder.com/50',
                    ),
                    SizedBox(height: 10),
                    TeacherTile(
                      name: 'John Doe',
                      rating: '4.5',
                      reviews: '13,657',
                      avatarUrl: 'https://via.placeholder.com/50',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
