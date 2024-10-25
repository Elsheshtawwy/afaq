import 'package:afaq/providers/auth_provider.dart';
import 'package:afaq/widgets/CustomTextField.dart';
import 'package:afaq/widgets/buttons/CustomButton.dart';
import 'package:afaq/widgets/buttons/socialIcons.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  final _forgotPasswordController = TextEditingController();
  bool _isLoading = false;
  

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email address';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  Widget _buildVisibilityIcon() {
    return IconButton(
      icon: Icon(
        _obscurePassword ? Icons.visibility : Icons.visibility_off,
        color: Colors.blue.shade600,
      ),
      onPressed: () {
        setState(() {
          _obscurePassword = !_obscurePassword;
        });
      },
    );
  }

  void _showLoadingIndicator(bool show) {
    setState(() {
      _isLoading = show;
    });
  }

  void _showAwesomeDialog(String title, String message, DialogType dialogType) {
    AwesomeDialog(
      context: context,
      dialogType: dialogType,
      animType: AnimType.bottomSlide,
      title: title,
      desc: message,
      btnOkOnPress: () {},
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
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
                      Image.asset(
                        'assets/images/logo.png',
                        height: screenHeight * 0.12,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.error, size: 100);
                        },
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      const Text(
                        'Welcome Back!',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Please enter your credentials to continue',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: screenHeight * 0.04),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            CustomTextField(
                              controller: _emailController,
                              labelText: 'Email',
                              keyboardType: TextInputType.emailAddress,
                              prefixIcon: Icon(CupertinoIcons.mail,
                                  color: Colors.blue.shade600),
                              validator: _validateEmail,
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            CustomTextField(
                              controller: _passwordController,
                              labelText: 'Password',
                              obscureText: _obscurePassword,
                              prefixIcon: Icon(CupertinoIcons.lock,
                                  color: Colors.blue.shade600),
                              suffixIcon: _buildVisibilityIcon(),
                              validator: _validatePassword,
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () async {
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.info,
                                    animType: AnimType.bottomSlide,
                                    title: 'Forgot Password',
                                    body: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text(
                                            'Please enter your email to reset your password:'),
                                        TextField(
                                          controller: _forgotPasswordController,
                                          decoration: const InputDecoration(
                                            labelText: 'Email',
                                            hintText: 'Enter your email',
                                          ),
                                        ),
                                      ],
                                    ),
                                    btnCancelOnPress: () {
                                      _forgotPasswordController.clear();
                                    },
                                    btnOkText: 'Submit',
                                    btnOkOnPress: () async {
                                      final email =
                                          _forgotPasswordController.text.trim();
                                      if (email.isNotEmpty) {
                                        if (RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                            .hasMatch(email)) {
                                          try {
                                            final methods = await FirebaseAuth
                                                .instance
                                                .fetchSignInMethodsForEmail(
                                                    email);
                                            if (methods.isNotEmpty) {
                                              await FirebaseAuth.instance
                                                  .sendPasswordResetEmail(
                                                      email: email);
                                              _showAwesomeDialog(
                                                  'Success',
                                                  'Password reset email sent',
                                                  DialogType.success);
                                              _forgotPasswordController.clear();
                                            } else {
                                              _showAwesomeDialog(
                                                  'Warning',
                                                  'This email is not registered',
                                                  DialogType.warning);
                                            }
                                          } catch (e) {
                                            _showAwesomeDialog(
                                                'Error',
                                                'Failed to send password reset email',
                                                DialogType.error);
                                          }
                                        } else {
                                          _showAwesomeDialog(
                                              'Warning',
                                              'Please enter a valid email address',
                                              DialogType.warning);
                                        }
                                      } else {
                                        _showAwesomeDialog(
                                            'Warning',
                                            'Please enter an email address',
                                            DialogType.warning);
                                      }
                                    },
                                  ).show();
                                },
                                child: const Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            CustomButton(
                              label: 'Log In',
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  _showLoadingIndicator(true);
                                  final authProvider = Provider.of<Auth_Provider>(
                                      context,
                                      listen: false);
                                  bool success = await authProvider.login(
                                    context,
                                    _emailController.text,
                                    _passwordController.text,
                                  );
                                  _showLoadingIndicator(false);
                                  if (success) {
                                    Navigator.pushReplacementNamed(
                                        context, '/home');
                                  } else {
                                    _showAwesomeDialog(
                                        'Error', 'Login failed', DialogType.error);
                                  }
                                }
                              },
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            const Text(
                              'Or Log In With',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
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
                                        await Auth_Provider().signInWithGoogle();
                                        Navigator.pushReplacementNamed(
                                            context, '/home');
                                      } catch (e) {
                                        _showAwesomeDialog(
                                            'Error',
                                            'Google Sign-In failed',
                                            DialogType.error);
                                      }
                                    },
                                    () {
                                      // Facebook Sign In
                                    }
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Don\'t have an account? ',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/signup');
                                  },
                                  child: const Text(
                                    'Sign Up',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
