import 'package:flutter/material.dart';
import 'package:afaq/pages/mainScreens/home_screen.dart';

class GetStartedButton extends StatelessWidget {
  const GetStartedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: Colors.white,
      child: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.lightBlue.shade700,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            textStyle:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
          child:
              const Text('Get Started', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
