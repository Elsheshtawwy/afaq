import 'package:afaq/providers/auth_provider.dart';
import 'package:afaq/providers/base_provider.dart';
import 'package:afaq/widgets/Auth_widgets/AuthOption.dart';
import 'package:afaq/widgets/Auth_widgets/ForgotPasswordWidget.dart';
import 'package:afaq/widgets/Auth_widgets/LogoWidget.dart';
import 'package:afaq/widgets/Auth_widgets/MainText.dart';
import 'package:afaq/widgets/Auth_widgets/SubtitleText.dart';
import 'package:afaq/widgets/Auth_widgets/VisibilityIcon.dart';
import 'package:afaq/widgets/Auth_widgets/validate.dart';
import 'package:afaq/widgets/TextField/CustomTextField.dart';
import 'package:afaq/widgets/buttons/CustomButton.dart';
import 'package:afaq/widgets/Auth_widgets/SocialSignUpOptions.dart';
import 'package:afaq/widgets/showAwesomeDialog/showAwesomeDialog.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  void _showLoadingIndicator(bool show) {
    setState(() {
      _isLoading = show;
    });
  }

  @override
  Widget build(BuildContext context) {
    final baseProvider = Provider.of<BaseProvider>(context);
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
                      LogoWidget(screenHeight: screenHeight),
                      SizedBox(height: screenHeight * 0.01),
                       MainText(
                        text: 'Welcome Back',
                        fontSize: 32,
                      ),
                      SizedBox(height: screenHeight * 0.01),
                       SubtitleText(
                        text: 'Log in to your account',
                        fontSize: 18,
                      ),
                      SizedBox(height: screenHeight * 0.04),
                      Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomTextField(
                              controller: _emailController,
                              labelText: 'Email',
                              keyboardType: TextInputType.emailAddress,
                              prefixIcon: Icon(CupertinoIcons.mail,
                                  color: Colors.blue.shade600),
                              validator: (value) =>
                                  Validator.validateEmail(value),
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            CustomTextField(
                              controller: _passwordController,
                              labelText: 'Password',
                              obscureText: _obscurePassword,
                              prefixIcon: Icon(CupertinoIcons.lock,
                                  color: Colors.blue.shade600),
                              suffixIcon: VisibilityIcon(
                                obscureText: _obscurePassword,
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                              validator: (value) =>
                                  Validator.validatePassword(value),
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            Align(
                              alignment: Alignment.centerRight,
                              child: ForgotPasswordWidget(
                                forgotPasswordController:
                                    _forgotPasswordController,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            CustomButton(
                              label: 'Log In',
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  _showLoadingIndicator(true);
                                  final authProvider =
                                      Provider.of<Auth_Provider>(context,
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
                                    AwesomeDialogHelper('Error', 'Login failed',
                                        DialogType.error);
                                  }
                                }
                              },
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            SocialSignUpOptions(
                              screenHeight: screenHeight,
                              baseProvider: baseProvider,
                              context: context,
                              text: 'Or Log In With',
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            const AuthOption(
                              text: 'Sign Up',
                              question: 'Don\'t have an account?',
                              route: '/signup',
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
