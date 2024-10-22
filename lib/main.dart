import 'package:afaq/pages/Onboarding/splash_screen.dart';
import 'package:afaq/providers/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
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
        ChangeNotifierProvider<Auth_Provider>(create: (_) => Auth_Provider())
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
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('***********************User is currently signed out!');
      } else {
        print('***********************User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Afaq',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF5F9FF),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF5F9FF),
          elevation: 0,
        ),
        primaryColor: const Color(0xFF4667FD),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4667FD)),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
