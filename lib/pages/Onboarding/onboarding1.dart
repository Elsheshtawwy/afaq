import 'package:afaq/pages/mainScreens/home_screen.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPageModel> pages = [
    OnboardingPageModel(
      title: 'Welcome to Our World!',
      description:
          'Discover amazing features that help you achieve your personal and professional goals.',
      image: 'assets/student.gif',
      backgroundColor: Colors.white,
    ),
    OnboardingPageModel(
      title: 'Learn and Enhance Your Skills!',
      description:
          'Get ready to expand your horizons with interactive courses designed just for you.',
      image: 'assets/graduate.gif',
      backgroundColor: Colors.white,
    ),
    OnboardingPageModel(
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
              child: Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue.shade700,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    textStyle:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                  child: Text('Get Started',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
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

class OnboardingPage extends StatelessWidget {
  final OnboardingPageModel page;

  OnboardingPage(this.page);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: page.backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(page.image, height: 250),
          SizedBox(height: 20),
          Text(
            page.title,
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              page.description,
              style: TextStyle(fontSize: 16, color: Colors.blue),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPageModel {
  final String title;
  final String description;
  final String image;
  final Color backgroundColor;

  OnboardingPageModel({
    required this.title,
    required this.description,
    required this.image,
    required this.backgroundColor,
  });
}

class PageIndicator extends StatelessWidget {
  final int currentPage;
  final int pageCount;

  PageIndicator({required this.currentPage, required this.pageCount});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(pageCount, (index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          height: 10,
          width: currentPage == index ? 25 : 10,
          decoration: BoxDecoration(
            color:
                currentPage == index ? Colors.lightBlue.shade700 : Colors.grey,
            borderRadius: BorderRadius.circular(5),
          ),
        );
      }),
    );
  }
}
