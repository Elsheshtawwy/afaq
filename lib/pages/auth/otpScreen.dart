import 'package:afaq/pages/mainScreens/home_screen.dart';
import 'package:afaq/widgets/CustomTextField.dart';
import 'package:afaq/widgets/buttons/CustomButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _otpController.clear();
  }

  @override
  void dispose() {
    _otpController.dispose();
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
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.lightBlue.shade100,
                    Colors.lightBlue.shade300,
                    Colors.lightBlue.shade700,
                  ],
                  stops: const [0.1, 0.5, 0.9],
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
                            const SizedBox(height: 16),
                            _buildTitle(getFontSize),
                            const SizedBox(height: 8),
                            _buildSubtitle(getFontSize),
                            const SizedBox(height: 20),
                            _buildOtpField(),
                            const SizedBox(height: 16),
                            _buildVerifyButton(primaryColor, getFontSize),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 16,
              left: 16,
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
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
      'OTP Verification',
      style: TextStyle(
        fontSize: getFontSize(26),
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildSubtitle(double Function(double) getFontSize) {
    return Text(
      'Enter the OTP sent to your email',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.black54,
        fontSize: getFontSize(16),
      ),
    );
  }

  Widget _buildOtpField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        OtpTextField(
            enabledBorderColor: Colors.grey,
          numberOfFields: 5,
          cursorColor: Colors.blue,
          borderColor: Color(0xFF512DA8),
          showFieldAsBox: true,
          fieldWidth: 40,
          borderRadius: BorderRadius.circular(8),
          onCodeChanged: (String code) {
            //handle validation or checks here
          },
          onSubmit: (String verificationCode) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Verification Code"),
                    content: Text('Code entered is $verificationCode'),
                  );
                });
          },
        ),
      ],
    );
  }

  Widget _buildVerifyButton(
      Color primaryColor, double Function(double) getFontSize) {
    return CustomButton(
      label: 'Verify',
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomePage()));
        }
      },
      buttonColor: primaryColor,
      labelFontSize: getFontSize(16),
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 64),
      borderRadius: 10,
      labelColor: Colors.white,
    );
  }
}
