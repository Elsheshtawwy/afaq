import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class AwesomeDialogHelper {
  final String message;
  final DialogType dialogType;
  final String title;

  AwesomeDialogHelper(
    this.title,
    this.message,
    this.dialogType,
  );

  void showAwesomeDialog(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: dialogType,
      animType: AnimType.bottomSlide,
      title: title,
      desc: message,
      btnOkOnPress: () {},
    ).show();
  }
}