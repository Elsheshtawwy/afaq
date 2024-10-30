import 'package:afaq/helpers/functions.dart';
import 'package:afaq/pages/auth/login_screen.dart';
import 'package:afaq/pages/auth/signup_screen.dart';
import 'package:afaq/widgets/buttons/CustomButton.dart';
import 'package:flutter/material.dart';

class WelcomeScreenButtons extends StatelessWidget {
  const WelcomeScreenButtons({super.key});

  Widget _buildButton(BuildContext context, String label, Widget screen) {
    return CustomButton(
      label: label,
      labelColor: Colors.blue.shade600,
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => screen,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildButton(context, 'Sign Up', const SignUpScreen()),
        SizedBox(height: getSize(context).height * 0.02),
        _buildButton(context, 'Login', const LoginScreen()),
      ],
    );
  }
}
