import 'package:afaq/pages/auth/signup_screen.dart';
import 'package:afaq/pages/mainScreens/home_screen.dart';
import 'package:afaq/widgets/CustomTextField.dart';
import 'package:afaq/widgets/buttons/CustomButton.dart';
import 'package:afaq/widgets/buttons/socialIcons.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _emailController.clear();
    _passwordController.clear();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final screenWidth = MediaQuery.of(context).size.width;

    double getFontSize(double baseSize) {
      return baseSize * (screenWidth / 375);
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                primaryColor.withOpacity(0.4),
                primaryColor.withOpacity(0.7),
                primaryColor.withOpacity(1.0),
              ],
              stops: [0.1, 0.5, 0.9],
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.85),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 15,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildLogo(),
                        const SizedBox(height: 20),
                        _buildTitle(getFontSize),
                        const SizedBox(height: 8),
                        _buildSubtitle(getFontSize),
                        const SizedBox(height: 20),
                        _buildEmailField(),
                        const SizedBox(height: 16),
                        _buildPasswordField(),
                        const SizedBox(height: 10),
                        _buildForgotPasswordButton(primaryColor, getFontSize),
                        const SizedBox(height: 16),
                        _buildLoginButton(primaryColor, getFontSize),
                        const SizedBox(height: 20),
                        _buildDividerWithText(getFontSize),
                        const SizedBox(height: 20),
                        buildSocialButtons(
                          [
                            "assets/socialLogos/light/google.png",
                            "assets/socialLogos/light/facebook.png",
                          ],
                          [
                            () {},
                            () {},
                          ],
                        ),
                        const SizedBox(height: 20),
                        _buildSignUpRow(primaryColor, getFontSize),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Image.asset(
      "assets/images/logo.png",
      height: 60,
      errorBuilder: (context, error, stackTrace) {
        return const Icon(Icons.error, size: 60);
      },
    );
  }

  Widget _buildTitle(double Function(double) getFontSize) {
    return Text(
      'Login',
      style: TextStyle(
        fontSize: getFontSize(26),
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildSubtitle(double Function(double) getFontSize) {
    return Text(
      'Enter your email and password to log in',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.black54,
        fontSize: getFontSize(16),
      ),
    );
  }

  Widget _buildEmailField() {
    return CustomTextField(
      controller: _emailController,
      labelText: 'Email',
      keyboardType: TextInputType.emailAddress,
      prefixIcon: const Icon(Icons.email_outlined),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
          return 'Please enter a valid email';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return CustomTextField(
      controller: _passwordController,
      labelText: 'Password',
      obscureText: _obscurePassword,
      prefixIcon: const Icon(Icons.lock_outline),
      suffixIcon: IconButton(
        icon: Icon(
          _obscurePassword ? Icons.visibility_off : Icons.visibility,
        ),
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
    );
  }

  Widget _buildForgotPasswordButton(
      Color primaryColor, double Function(double) getFontSize) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {},
        child: Text(
          'Forgot Password ?',
          style: TextStyle(
            color: primaryColor,
            fontSize: getFontSize(14),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton(
      Color primaryColor, double Function(double) getFontSize) {
    return CustomButton(
      label: 'Log In',
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) =>  HomePage()));
        }
      },
      buttonColor: primaryColor,
      labelFontSize: getFontSize(16),
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 64),
      borderRadius: 10,
      labelColor: Colors.white,
    );
  }

  Widget _buildDividerWithText(double Function(double) getFontSize) {
    return Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            'Or login with',
            style: TextStyle(fontSize: getFontSize(14)),
          ),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }

  Widget _buildSignUpRow(
      Color primaryColor, double Function(double) getFontSize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account?",
          style: TextStyle(fontSize: getFontSize(14)),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignUpScreen()));
          },
          child: Text(
            'Sign Up',
            style: TextStyle(
              color: primaryColor,
              fontSize: getFontSize(14),
            ),
          ),
        ),
      ],
    );
  }
}
