import 'package:flutter/material.dart';

class MainText extends StatelessWidget {
  final String text;
  final double fontSize;
  const MainText({Key? key, required this.text, required this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        shadows: const [
          Shadow(
            blurRadius: 10.0,
            color: Colors.black45,
            offset: Offset(2.0, 2.0),
          ),
        ],
      ),
    );
  }
}
