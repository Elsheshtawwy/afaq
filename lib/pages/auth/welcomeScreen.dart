import 'package:afaq/providers/base_provider.dart';
import 'package:afaq/widgets/Auth_widgets/LogoWidget.dart';
import 'package:afaq/widgets/Auth_widgets/MainText.dart';
import 'package:afaq/widgets/Auth_widgets/SubtitleText.dart';
import 'package:afaq/widgets/Auth_widgets/SocialSignUpOptions.dart';
import 'package:afaq/widgets/Auth_widgets/welcome_screen_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    BaseProvider baseProvider = BaseProvider();
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = constraints.maxWidth;
            final screenHeight = constraints.maxHeight;

            return Container(
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
                      LogoWidget(
                        screenHeight: screenHeight,
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      MainText(
                        text: 'Welcome to Afaq',
                        fontSize: 32,
                      ),
                      const SizedBox(height: 8),
                      SubtitleText(
                        text: 'Your Learning Companion',
                        fontSize: 18,
                      ),
                      SizedBox(height: screenHeight * 0.05),
                      WelcomeScreenButtons(),
                      SizedBox(height: screenHeight * 0.03),
                      SocialSignUpOptions(
                        screenHeight: screenHeight,
                        context: context,
                        baseProvider: baseProvider,
                        text: 'Or Sign Up With',
                        fontSize: 16,
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
