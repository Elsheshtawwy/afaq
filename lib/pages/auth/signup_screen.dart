import 'package:afaq/providers/auth_provider.dart';
import 'package:afaq/providers/base_provider.dart';
import 'package:afaq/widgets/Auth_widgets/AuthOption.dart';
import 'package:afaq/widgets/Auth_widgets/LogoWidget.dart';
import 'package:afaq/widgets/Auth_widgets/MainText.dart';
import 'package:afaq/widgets/Auth_widgets/SubtitleText.dart';
import 'package:afaq/widgets/Auth_widgets/VisibilityIcon.dart';
import 'package:afaq/widgets/TextField/CustomTextField.dart';
import 'package:afaq/widgets/buttons/CustomButton.dart';
import 'package:afaq/widgets/Auth_widgets/SocialSignUpOptions.dart';
import 'package:afaq/widgets/showAwesomeDialog/showAwesomeDialog.dart';
import 'package:afaq/widgets/Auth_widgets/validate.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';

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
  bool _isLoading = false;
  late BaseProvider base_provider;

  @override
  void initState() {
    super.initState();
    base_provider = Provider.of<BaseProvider>(context, listen: false);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate() && _agreeToTerms) {
      var status = await Permission.storage.request();
      if (status.isGranted) {
        setState(() {
          _isLoading = true;
        });
        try {
          final authProvider =
              Provider.of<Auth_Provider>(context, listen: false);
          final result = await authProvider.createAccount(
            context,
            _emailController.text,
            _passwordController.text,
          );

          if (result) {
            base_provider.setBusy(true);
            Navigator.pushNamed(context, '/AccountTypeScreen');
            base_provider.setBusy(false);
          }
        } catch (e) {
          AwesomeDialogHelper('Error', 'An error occurred. Please try again.',
              DialogType.error);
        } finally {
          setState(() {
            _isLoading = false;
          });
        }
      } else {
        AwesomeDialogHelper('Permission Denied',
            'Storage permission is required to proceed.', DialogType.warning);
      }
    } else if (!_agreeToTerms) {
      AwesomeDialogHelper('Terms & Conditions',
          'You must agree to the terms and conditions.', DialogType.warning);
    }
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
          child: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ))
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: screenHeight * 0.01),
                        LogoWidget(
                          screenHeight: screenHeight,
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        const MainText(text: 'Sign Up', fontSize: 32),
                        SizedBox(height: screenHeight * 0.01),
                        const SubtitleText(
                          text: 'Create an account to get started',
                          fontSize: 18,
                        ),
                        SizedBox(height: screenHeight * 0.03),
                        _buildSignUpForm(screenHeight),
                        SizedBox(height: screenHeight * 0.02),
                        SocialSignUpOptions(
                          screenHeight: screenHeight,
                          baseProvider: base_provider,
                          context: context,
                          text: 'Or Sign Up With',
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        const AuthOption(
                          text: 'Login',
                          question: 'Already have an account?',
                          route: '/login',
                        )
                      ],
                    ),
                  ),
                ),
        ),
      ),
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
            validator: (value) => Validator.validateEmail(value),
          ),
          SizedBox(height: screenHeight * 0.02),
          CustomTextField(
            controller: _passwordController,
            labelText: 'Password',
            obscureText: _obscurePassword,
            prefixIcon: Icon(CupertinoIcons.lock, color: Colors.blue.shade600),
            suffixIcon: VisibilityIcon(
              obscureText: _obscurePassword,
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
            validator: (value) => Validator.validatePassword(value),
          ),
          SizedBox(height: screenHeight * 0.02),
          CustomTextField(
            controller: _confirmPasswordController,
            labelText: 'Confirm Password',
            obscureText: _obscureConfirmPassword,
            prefixIcon: Icon(CupertinoIcons.lock, color: Colors.blue.shade600),
            suffixIcon: VisibilityIcon(
              obscureText: _obscureConfirmPassword,
              onPressed: () {
                setState(() {
                  _obscureConfirmPassword = !_obscureConfirmPassword;
                });
              },
            ),
            validator: (value) => Validator.validateConfirmPassword(
                value, _passwordController.text),
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
}
