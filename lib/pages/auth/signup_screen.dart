import 'package:afaq/pages/auth/UserInfoScreen.dart';
import 'package:afaq/pages/auth/login_screen.dart';
import 'package:afaq/providers/auth_provider.dart';
import 'package:afaq/widgets/CustomTextField.dart';
import 'package:afaq/widgets/buttons/CustomButton.dart';
import 'package:afaq/widgets/buttons/socialIcons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agreeToTerms = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      try {
        final authProvider = Provider.of<Auth_Provider>(context, listen: false);
        final result = await authProvider.createAccount(
          context,
          _emailController.text,
          _passwordController.text,
        );

        if (result) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UserInfoScreen()),
          );
        }
      } catch (e) {
        _showSnackBar('An error occurred. Please try again.');
      }
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: screenHeight * 0.01),
                  _buildLogo(screenHeight),
                  SizedBox(height: screenHeight * 0.01),
                  _buildWelcomeText(),
                  SizedBox(height: screenHeight * 0.04),
                  _buildSignUpForm(screenHeight),
                  SizedBox(height: screenHeight * 0.02),
                  _buildSocialSignUpOptions(screenHeight),
                  SizedBox(height: screenHeight * 0.02),
                  _buildSignInOption(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(double screenHeight) {
    return Image.asset(
      'assets/images/logo.png',
      height: screenHeight * 0.12,
      errorBuilder: (context, error, stackTrace) {
        return const Icon(Icons.error, size: 100);
      },
    );
  }

  Widget _buildWelcomeText() {
    return Column(
      children: const [
        Text(
          'Welcome!',
          style: TextStyle(
              fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        SizedBox(height: 8),
        Text(
          'Create an account to access all features',
          style: TextStyle(fontSize: 16, color: Colors.white70),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildSignUpForm(double screenHeight) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextField(
            controller: _emailController,
            labelText: 'Email',
            keyboardType: TextInputType.emailAddress,
            prefixIcon: Icon(CupertinoIcons.mail, color: Colors.blue.shade600),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
          SizedBox(height: screenHeight * 0.02),
          CustomTextField(
            controller: _passwordController,
            labelText: 'Password',
            obscureText: _obscurePassword,
            prefixIcon: Icon(CupertinoIcons.lock, color: Colors.blue.shade600),
            suffixIcon: IconButton(
              icon: Icon(
                  _obscurePassword ? Icons.visibility : Icons.visibility_off,
                  color: Colors.blue.shade600),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters long';
              }
              return null;
            },
          ),
          SizedBox(height: screenHeight * 0.02),
          CustomTextField(
            controller: _confirmPasswordController,
            labelText: 'Confirm Password',
            obscureText: _obscureConfirmPassword,
            prefixIcon: Icon(CupertinoIcons.lock, color: Colors.blue.shade600),
            suffixIcon: IconButton(
              icon: Icon(
                  _obscureConfirmPassword
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Colors.blue.shade600),
              onPressed: () {
                setState(() {
                  _obscureConfirmPassword = !_obscureConfirmPassword;
                });
              },
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please confirm your password';
              }
              if (value != _passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
          SizedBox(height: screenHeight * 0.02),
          _buildTermsAndConditionsCheckbox(),
          SizedBox(height: screenHeight * 0.01),
          CustomButton(label: 'Sign Up', onPressed: _signUp),
        ],
      ),
    );
  }

  Widget _buildTermsAndConditionsCheckbox() {
    return Row(
      children: [
        Checkbox(
          activeColor: Colors.white,
          checkColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: const BorderSide(color: Colors.white),
          ),
          side: const BorderSide(color: Colors.white),
          value: _agreeToTerms,
          onChanged: (value) {
            setState(() {
              _agreeToTerms = value ?? false;
            });
          },
        ),
        const Text(
          'I agree to the Terms & Conditions',
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildSocialSignUpOptions(double screenHeight) {
    return Column(
      children: [
        const Text(
          'Or Sign Up With',
          style: TextStyle(color: Colors.white, fontSize: 14),
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
                () {
                  signInWithGoogle();
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

  Widget _buildSignInOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Already have an account? ',
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: TextButton(
            child: const Text(
              'Sign In',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange),
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
          ),
        ),
      ],
    );
  }
}
