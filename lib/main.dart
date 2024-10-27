import 'package:afaq/pages/MyProfileScreens/EditProfile.dart';
import 'package:afaq/pages/MyProfileScreens/LanguageSelectionScreen.dart';
import 'package:afaq/pages/MyProfileScreens/NotificationScreen.dart';
import 'package:afaq/pages/MyProfileScreens/TermsAndConditions.dart';
import 'package:afaq/pages/auth/FeedScreen.dart';
import 'package:afaq/pages/auth/UserInfoScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'package:afaq/pages/Onboarding/onboardingScreen.dart';
import 'package:afaq/pages/splash/splash_screen.dart';
import 'package:afaq/pages/auth/login_screen.dart';
import 'package:afaq/pages/auth/signup_screen.dart';
import 'package:afaq/pages/mainScreens/home_screen.dart';
import 'package:afaq/providers/auth_provider.dart';
import 'package:afaq/providers/base_provider.dart';
import 'package:afaq/providers/dark_mode_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<BaseProvider>(create: (_) => BaseProvider()),
        ChangeNotifierProvider<DarkModeProvider>(
            create: (_) => DarkModeProvider()),
        ChangeNotifierProvider<Auth_Provider>(create: (_) => Auth_Provider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        debugPrint('User is currently signed out!');
      } else {
        debugPrint('User is signed in!');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Afaq',
      theme: _buildThemeData(),
      home: const HomePage(),
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/home': (context) => const HomePage(),
        '/feed': (context) => const FeedScreen(
              selectedUserType: 'Learner',
            ),
        '/userInfo': (context) => const UserInfoScreen(),
        '/termsAndConditions': (context) => const TermsAndConditionsScreen(),
        '/LanguageSelection': (context) => LanguageSelectionScreen(),
        '/editProfile': (context) => const EditProfile(),
        '/notifications': (context) => const NotificationScreen(),
      },
    );
  }

  ThemeData _buildThemeData() {
    return ThemeData(
      scaffoldBackgroundColor: const Color(0xFFF5F9FF),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFF5F9FF),
        elevation: 0,
      ),
      primaryColor: const Color(0xFF4667FD),
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4667FD)),
      useMaterial3: true,
    );
  }
}
