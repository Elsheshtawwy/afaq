import 'package:afaq/pages/auth/welcomeScreen.dart';
import 'package:afaq/pages/mainScreens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class ScreenRouter extends StatefulWidget {
  const ScreenRouter({super.key});

  @override
  State<ScreenRouter> createState() => _ScreenRouterState();
}

class _ScreenRouterState extends State<ScreenRouter> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return (firebaseAuth.currentUser != null &&
            firebaseAuth.currentUser!.emailVerified)
        ? const HomePage()
        : const WelcomeScreen();
  }
}
