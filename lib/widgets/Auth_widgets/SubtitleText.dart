  import 'package:flutter/material.dart';

  class SubtitleText extends StatelessWidget {
    final String text;
    final double fontSize;
    const SubtitleText({super.key, required this.text, required this.fontSize});

    @override
    Widget build(BuildContext context) {
      return  Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          color: Colors.white70,
          shadows: const [
            Shadow(
              blurRadius: 5.0,
              color: Colors.black26,
              offset: Offset(1.0, 1.0),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      );
    }
  }