import 'dart:async';

import 'package:afaq/helpers/functions.dart';
import 'package:afaq/pages/auth/login_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Timer _loadingTimer;
  String _loadingText = 'Loading';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.bounceInOut);

    _controller.repeat(reverse: true);

    _loadingTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        if (_loadingText.endsWith('...')) {
          _loadingText = 'Loading';
        } else {
          _loadingText += '.';
        }
      });
    });

    Timer(const Duration(seconds: 3), () {
      _loadingTimer.cancel();
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _loadingTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.lightBlue.shade100,
              Colors.lightBlue.shade300,
              Colors.lightBlue.shade700,
            ],
            stops: [0.1, 0.5, 0.9],
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 4,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _animation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ScaleTransition(
                  scale: _animation,
                  child: Image.asset(
                    "assets/images/logo.png",
                    width: getSize(context).width * 0.4,
                  ),
                ),
                const SizedBox(height: 20),
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
                const SizedBox(height: 20),
                Text(
                  _loadingText,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
