  import 'package:flutter/material.dart';

  class LogoWidget extends StatelessWidget {
    final double screenHeight;

    const LogoWidget({required this.screenHeight});

    @override
    Widget build(BuildContext context) {
      return Image.asset(
        'assets/images/logo.png',
        height: screenHeight * 0.12,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.error, size: 100);
        },
      );
    }
  }