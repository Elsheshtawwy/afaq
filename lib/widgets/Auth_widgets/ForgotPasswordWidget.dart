import 'package:afaq/widgets/showAwesomeDialog/showAwesomeDialog.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordWidget extends StatelessWidget {
  final TextEditingController forgotPasswordController;

  const ForgotPasswordWidget({super.key, required this.forgotPasswordController});

  Future<void> _onForgotPasswordPressed(BuildContext context) async {
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
            controller: forgotPasswordController,
            decoration: const InputDecoration(
              labelText: 'Email',
              hintText: 'Enter your email',
            ),
          ),
        ],
      ),
      btnCancelOnPress: () {
        forgotPasswordController.clear();
      },
      btnOkText: 'Submit',
      btnOkOnPress: () async {
        final email = forgotPasswordController.text.trim();
        if (email.isNotEmpty) {
          if (RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
        try {
          final methods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
          if (methods.isNotEmpty) {
            await FirebaseAuth.instance
            .sendPasswordResetEmail(email: email);
            AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.bottomSlide,
          title: 'Success',
          desc: 'Password reset email sent',
          btnOkOnPress: () {},
            ).show();
            forgotPasswordController.clear();
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
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => _onForgotPasswordPressed(context),
      child: const Text(
        'Forgot Password?',
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
      ),
    );
  }
}
