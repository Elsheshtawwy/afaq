import 'package:afaq/providers/auth_provider.dart';
import 'package:afaq/providers/base_provider.dart';
import 'package:afaq/widgets/buttons/socialIcons.dart';
import 'package:afaq/widgets/showAwesomeDialog/showAwesomeDialog.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class SocialSignUpOptions extends StatelessWidget {
  final double screenHeight;
  final BaseProvider baseProvider;
  final BuildContext context;
  final String text;
  final double? fontSize;

  const SocialSignUpOptions({super.key, 
    required this.screenHeight,
    required this.baseProvider,
    required this.context,
    this.fontSize = 14,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: fontSize),
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
                    baseProvider.setBusy(false);
                    await Auth_Provider().signInWithGoogle();
                    
                    Navigator.pushReplacementNamed(context, '/home');

                    baseProvider.setBusy(true);
                  } catch (e) {
                    AwesomeDialogHelper(
                        'Error', 'Google Sign-In failed', DialogType.error);
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
    );
  }
}
