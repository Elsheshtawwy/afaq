import 'package:afaq/models/OnboardingScreenModel.dart';
import 'package:afaq/widgets/onboarding/get_started_button.dart';
import 'package:afaq/widgets/onboarding/onboarding_page.dart';
import 'package:afaq/widgets/onboarding/page_indicator.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingScreenModel> pages = [
    OnboardingScreenModel(
      title: 'Welcome to Our World!',
      description:
          'Discover amazing features that help you achieve your personal and professional goals.',
      image: 'assets/student.gif',
      backgroundColor: Colors.white,
    ),
    OnboardingScreenModel(
      title: 'Learn and Enhance Your Skills!',
      description:
          'Get ready to expand your horizons with interactive courses designed just for you.',
      image: 'assets/graduate.gif',
      backgroundColor: Colors.white,
    ),
    OnboardingScreenModel(
      title: 'Join Our Vibrant Community!',
      description:
          'Be part of a unique experience with like-minded individuals who share your passions.',
      image: 'assets/community.gif',
      backgroundColor: Colors.white,
    ),
  ];

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        itemCount: pages.length,
        itemBuilder: (context, index) {
          return OnboardingPage(pages[index]);
        },
      ),
      bottomSheet: _currentPage == pages.length - 1
          ? Container(
              height: 80,
              color: Colors.white,
              child: const Center(child: GetStartedButton()),
            )
          : Container(
              height: 80,
              color: Colors.white,
              child: PageIndicator(
                currentPage: _currentPage,
                pageCount: pages.length,
              ),
            ),
    );
  }
}
