import 'package:afaq/models/OnboardingScreenModel.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingScreenModel page;

  const OnboardingPage(this.page, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: page.backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(page.image, height: 250),
          const SizedBox(height: 20),
          Text(
            page.title,
            style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              page.description,
              style: const TextStyle(fontSize: 16, color: Colors.blue),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
