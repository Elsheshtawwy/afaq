import 'package:afaq/models/CategoryModel.dart';
import 'package:afaq/models/CourseModel.dart';
import 'package:afaq/models/InstituteModel.dart';
import 'package:afaq/models/InstructorModel.dart';
import 'package:afaq/pages/auth/login_screen.dart';
import 'package:afaq/pages/auth/otpScreen.dart';
import 'package:afaq/widgets/CustomTextField.dart';
import 'package:afaq/widgets/buttons/CustomButton.dart';
import 'package:afaq/widgets/buttons/socialIcons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  final List<CourseModel> courses;
  final List<InstructorModel> instructors;
  final List<InstituteModel> institutes;
  final List<CategoryModel> categories;
  const SignUpScreen(
      {super.key,
      required this.courses,
      required this.instructors,
      required this.institutes,
      required this.categories});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agreeToTerms = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
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
                  Image.asset(
                    'assets/images/logo.png',
                    height: screenHeight * 0.12,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.error, size: 100);
                    },
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  const Text(
                    'Welcome!',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Create an account to access all features',
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
                          controller: _phoneController,
                          labelText: 'Phone Number',
                          keyboardType: TextInputType.phone,
                          prefixIcon: Icon(CupertinoIcons.phone,
                              color: Colors.blue.shade600),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                              return 'Please enter a valid phone number';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        CustomTextField(
                          controller: _passwordController,
                          labelText: 'Password',
                          obscureText: _obscurePassword,
                          prefixIcon: Icon(CupertinoIcons.lock,
                              color: Colors.blue.shade600),
                          suffixIcon: IconButton(
                            icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
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
                          prefixIcon: Icon(CupertinoIcons.lock,
                              color: Colors.blue.shade600),
                          suffixIcon: IconButton(
                            icon: Icon(
                                _obscureConfirmPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.blue.shade600),
                            onPressed: () {
                              setState(() {
                                _obscureConfirmPassword =
                                    !_obscureConfirmPassword;
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
                        Row(
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
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        CustomButton(
                          label: 'Sign Up',
                          onPressed: () {
                            // if (!_agreeToTerms) {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //     SnackBar(
                            //       content: Text(
                            //         'You must agree to the terms and conditions to sign up.',
                            //       ),
                            //       behavior: SnackBarBehavior.floating,
                            //       shape: RoundedRectangleBorder(
                            //         borderRadius: BorderRadius.circular(12),
                            //       ),
                            //     ),
                            //   );
                            //   return;
                            // }

                            // if (_formKey.currentState!.validate()) {
                            //   Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => const HomePage(),
                            //     ),
                            //   );
                            // }
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OtpScreen(
                                  courses: widget.courses,
                                  instructors: widget.instructors,
                                  institutes: widget.institutes,
                                  categories: widget.categories,
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: screenHeight * 0.02),
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
                                  // Google Sign In
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
                              'Already have an account? ',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
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
                                    color: Colors.orange,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginScreen(
                                        courses: widget.courses,
                                        instructors: widget.instructors,
                                        institutes: widget.institutes,
                                        categories: widget.categories,
                                      ),
                                    ),
                                  );
                                },
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
      ),
    );
  }
}
