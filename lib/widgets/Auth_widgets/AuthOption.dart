  import 'package:flutter/material.dart';

  class AuthOption extends StatelessWidget {
    final String text;
    final String question;
    final String route;

    const AuthOption({super.key, required this.text, required this.question, required this.route});

    @override
    Widget build(BuildContext context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Text(
            question,
            style: const TextStyle(fontSize: 14, color: Colors.white),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: TextButton(
              child: Text(
                text,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange),
              ),
              onPressed: () {
                Navigator.pushNamed(context, route);
              },
            ),
          ),
        ],
      );
    }
  }