import 'package:afaq/pages/mainScreens/home_screen.dart';
import 'package:afaq/widgets/CustomTextField.dart';
import 'package:afaq/widgets/buttons/CustomButton.dart';
import 'package:afaq/widgets/buttons/socialIcons.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = constraints.maxWidth;

            double getFontSize(double baseSize) {
              return baseSize * (screenWidth / 375);
            }

            return Container(
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
                            _buildNameField(),
                            const SizedBox(height: 16),
                            _buildEmailField(),
                            const SizedBox(height: 16),
                            _buildPasswordField(),
                            const SizedBox(height: 16),
                            _buildConfirmPasswordField(),
                            const SizedBox(height: 16),
                            _buildSignUpButton(primaryColor, getFontSize),
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
                            _buildLoginRow(primaryColor, getFontSize),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
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
      'Sign Up',
      style: TextStyle(
        fontSize: getFontSize(26),
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildSubtitle(double Function(double) getFontSize) {
    return Text(
      'Create your account by filling the form below',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.black54,
        fontSize: getFontSize(16),
      ),
    );
  }

  Widget _buildNameField() {
    return CustomTextField(
      controller: _nameController,
      labelText: 'Name',
      keyboardType: TextInputType.name,
      prefixIcon: const Icon(Icons.person_outline),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your name';
        }
        return null;
      },
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

  Widget _buildConfirmPasswordField() {
    return CustomTextField(
      controller: _confirmPasswordController,
      labelText: 'Confirm Password',
      obscureText: _obscureConfirmPassword,
      prefixIcon: const Icon(Icons.lock_outline),
      suffixIcon: IconButton(
        icon: Icon(
          _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
        ),
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
    );
  }

  Widget _buildSignUpButton(
      Color primaryColor, double Function(double) getFontSize) {
    return CustomButton(
      label: 'Sign Up',
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePage()));
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
            'Or sign up with',
            style: TextStyle(fontSize: getFontSize(14)),
          ),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }

  Widget _buildSocialLoginButtons(List<IconData> icons) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(icons.length, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: IconButton(
            icon: FaIcon(icons[index]),
            onPressed: () {},
            iconSize: 32,
          ),
        );
      }),
    );
  }

  Widget _buildLoginRow(
      Color primaryColor, double Function(double) getFontSize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account?",
          style: TextStyle(fontSize: getFontSize(14)),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Log In',
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
