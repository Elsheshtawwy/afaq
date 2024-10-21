// import 'dart:async';
// import 'package:afaq/pages/auth/UserInfoScreen.dart';
// import 'package:afaq/widgets/buttons/CustomButton.dart';
// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
// import 'package:flutter/material.dart';

// class OtpScreen extends StatefulWidget {
//   const OtpScreen({super.key});

//   @override
//   _OtpScreenState createState() => _OtpScreenState();
// }

// class _OtpScreenState extends State<OtpScreen> {
//   final _otpController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   bool _isLoading = false;
//   int _resendCounter = 30;
//   bool _canResend = true;
//   String _verificationCode = '';
//   String _sentCode = '12345'; 

//   @override
//   void initState() {
//     FirebaseAuth.instance.currentUser!.emailVerified
//      ? Navigator.push(context, MaterialPageRoute(builder: (context) => UserInfoScreen())) 
//      : null;   
//      super.initState();
//   }

//   @override
//   void dispose() {
//     _otpController.dispose();
//     super.dispose();
//   }

//   void _verifyCode() async {
//     if (_formKey.currentState!.validate() && _verificationCode.isNotEmpty) {
//       setState(() {
//         _isLoading = true;
//       });

//       if (_verificationCode == _sentCode) {
//         bool isEmailVerified = await _checkEmailVerification();

//         setState(() {
//           _isLoading = false;
//         });

//         if (isEmailVerified) {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => const UserInfoScreen(),
//             ),
//           );
//         } else {
//           AwesomeDialog(
//             context: context,
//             dialogType: DialogType.error,
//             animType: AnimType.bottomSlide,
//             title: 'Verification Failed',
//             desc: 'Email verification failed. Please try again.',
//             btnOkOnPress: () {},
//           ).show();
//         }
//       } else {
//         setState(() {
//           _isLoading = false;
//         });
//         AwesomeDialog(
//           context: context,
//           dialogType: DialogType.error,
//           animType: AnimType.bottomSlide,
//           title: 'Invalid Code',
//           desc: 'The code you entered is incorrect. Please try again.',
//           btnOkOnPress: () {},
//         ).show();
//       }
//     } else {
//       AwesomeDialog(
//         context: context,
//         dialogType: DialogType.warning,
//         animType: AnimType.bottomSlide,
//         title: 'Invalid Code',
//         desc: 'Please enter the verification code.',
//         btnOkOnPress: () {},
//       ).show();
//     }
//   }

//   Future<bool> _checkEmailVerification() async {
  
//     await Future.delayed(const Duration(seconds: 2));
//     return true; 
//   }

//   void _resendCode() {
//     if (_canResend) {
//       setState(() {
//         _canResend = false;
//         _resendCounter = 30;
//       });

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Code has been resent')),
//       );

//       Timer.periodic(const Duration(seconds: 1), (timer) {
//         setState(() {
//           _resendCounter--;
//         });

//         if (_resendCounter == 0) {
//           timer.cancel();
//           setState(() {
//             _canResend = true;
//           });
//         }
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           width: double.infinity,
//           height: double.infinity,
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 Colors.blue.shade200,
//                 Colors.blue.shade500,
//                 Colors.blue.shade700
//               ],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             ),
//           ),
//           child: Center(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(24.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     SizedBox(height: screenHeight * 0.01),
//                     _buildLogo(screenHeight),
//                     SizedBox(height: screenHeight * 0.01),
//                     _buildTitle(),
//                     const SizedBox(height: 8),
//                     _buildSubtitle(),
//                     SizedBox(height: screenHeight * 0.04),
//                     _buildForm(screenHeight),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildLogo(double screenHeight) {
//     return Image.asset(
//       'assets/images/logo.png',
//       height: screenHeight * 0.12,
//       errorBuilder: (context, error, stackTrace) {
//         return const Icon(Icons.error, size: 100);
//       },
//     );
//   }

//   Widget _buildTitle() {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         double fontSize = constraints.maxWidth * 0.08;
//         return AutoSizeText(
//           'Verify Your Email Address',
//           style: TextStyle(
//             fontSize: fontSize,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//           maxLines: 1,
//         );
//       },
//     );
//   }

//   Widget _buildSubtitle() {
//     return const Text(
//       'We have sent a code to your email address',
//       style: TextStyle(
//         fontSize: 16,
//         color: Colors.white70,
//       ),
//       textAlign: TextAlign.center,
//     );
//   }

//   Widget _buildForm(double screenHeight) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         children: [
//           OtpTextField(
//             numberOfFields: 5,
//             cursorColor: Colors.white,
//             borderColor: const Color(0xFF0961F5),
//             showFieldAsBox: true,
//             onCodeChanged: (String code) {},
//             onSubmit: (String verificationCode) {
//               setState(() {
//                 _verificationCode = verificationCode;
//               });
//             },
//           ),
//           SizedBox(height: screenHeight * 0.02),
//           _isLoading
//               ? const CircularProgressIndicator()
//               : CustomButton(
//                   label: 'Verify Code',
//                   onPressed: _verifyCode,
//                 ),
//           SizedBox(height: screenHeight * 0.02),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text(
//                 'Didn\'t receive the code? ',
//                 style: TextStyle(fontSize: 14, color: Colors.white),
//               ),
//               GestureDetector(
//                 onTap: _canResend ? _resendCode : null,
//                 child: Text(
//                   _canResend ? 'Resend' : 'Resend in $_resendCounter seconds',
//                   style: const TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.orange,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
