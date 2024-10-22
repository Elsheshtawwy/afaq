import 'package:afaq/pages/auth/signup_screen.dart';
import 'package:afaq/pages/mainScreens/home_screen.dart';
import 'package:afaq/providers/auth_provider.dart';
import 'package:afaq/widgets/CustomTextField.dart';
import 'package:afaq/widgets/buttons/CustomButton.dart';
import 'package:afaq/widgets/buttons/socialIcons.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email address';
                            }
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                .hasMatch(value)) {
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
                                const Text('Please enter your email to reset your password:'),
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
                              final email = _forgotPasswordController.text.trim();
                              if (email.isNotEmpty) {
                                if (RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
                                try {
                                  final methods = await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
                                  if (methods.isNotEmpty) {
                                  await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.success,
                                    animType: AnimType.bottomSlide,
                                    title: 'Success',
                                    desc: 'Password reset email sent',
                                    btnOkOnPress: () {},
                                  ).show();
                                  _forgotPasswordController.clear();
                                  } else {
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.warning,
                                    animType: AnimType.bottomSlide,
                                    title: 'Warning',
                                    desc: 'This email is not registered',
                                    btnOkOnPress: () {},
                                  ).show();
                                  }
                                } catch (e) {
                                  AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.error,
                                  animType: AnimType.bottomSlide,
                                  title: 'Error',
                                  desc: 'Failed to send password reset email',
                                  btnOkOnPress: () {},
                                  ).show();
                                }
                                } else {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.warning,
                                  animType: AnimType.bottomSlide,
                                  title: 'Warning',
                                  desc: 'Please enter a valid email address',
                                  btnOkOnPress: () {},
                                ).show();
                                }
                              } else {
                                AwesomeDialog(
                                context: context,
                                dialogType: DialogType.warning,
                                animType: AnimType.bottomSlide,
                                title: 'Warning',
                                desc: 'Please enter an email address',
                                btnOkOnPress: () {},
                                ).show();
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
                              final authProvider = Provider.of<Auth_Provider>(
                                  context,
                                  listen: false);
                              bool success = await authProvider.login(
                                context,
                                _emailController.text,
                                _passwordController.text,
                              );
                              if (success) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const HomePage(),
                                  ),
                                );
                              } else {
                                // Handle login failure (e.g., show a snackbar)
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Login failed')),
                                );
                              }
                            }
                          },
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        const Text(
                          'Or Log In With',
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
                        SizedBox(height: screenHeight * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an account? ',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignUpScreen(),
                                  ),
                                );
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
      ),
    );
  }
}
