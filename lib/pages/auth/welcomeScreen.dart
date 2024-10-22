import 'package:afaq/pages/auth/signup_screen.dart';
import 'package:afaq/pages/auth/login_screen.dart';
import 'package:afaq/pages/mainScreens/home_screen.dart';
import 'package:afaq/widgets/buttons/CustomButton.dart';
import 'package:afaq/widgets/buttons/socialIcons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({
    super.key,
  });

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue.shade200,
                Colors.blue.shade500,
                Colors.blue.shade700
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: screenHeight * 0.01),
                  Image.asset(
                    'assets/images/logo.png',
                    height: screenHeight * 0.12,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.error, size: 100);
                    },
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  const Text(
                    'Welcome!',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black45,
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Find the things that you Love!',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white70,
                      shadows: [
                        Shadow(
                          blurRadius: 5.0,
                          color: Colors.black26,
                          offset: Offset(1.0, 1.0),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  CustomButton(
                    label: 'Sign Up',
                    labelColor: Colors.blue.shade600,
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ),
                      );
                    },
                    buttonColor: Colors.white,
                    textStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.blue.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                    borderRadius: 30,
                    elevation: 5,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  CustomButton(
                    label: 'Login',
                    labelColor: Colors.blue.shade600,
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    buttonColor: Colors.white,
                    textStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.blue.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                    borderRadius: 30,
                    elevation: 5,
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  const Text(
                    'Or Sign Up With',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildSocialButtons(
                        [
                          'assets/socialLogos/light/google.png',
                          'assets/socialLogos/light/facebook.png',
                        ],
                        [
                          () async {
                                  try {
                                    await signInWithGoogle();
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const HomePage(),
                                      ),
                                    );
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Google Sign-In failed')),
                                    );
                                  }
                                },
                          () {
                            // Facebook Sign In
                          }
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
