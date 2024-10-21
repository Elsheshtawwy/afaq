import 'package:afaq/providers/base_provider.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Auth_Provider extends BaseProvider {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool loading = false;

  Future<bool> login(BuildContext context, String email, String password) async {
    setBusy(true);
    try {
      UserCredential userCred = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      if (userCred.user != null && userCred.user!.emailVerified) {
        setBusy(false);
        return true;
      } else {
        setBusy(false);
        _showErrorDialog(context, 'Email Not Verified', 'Please verify your email before logging in.');
        return false;
      }
    } on FirebaseAuthException catch (e) {
      setBusy(false);
      _showErrorDialog(context, 'Login Error', 'An error occurred while trying to log in: ${e.message}');
      return false;
    } catch (e) {
      setBusy(false);
      _showErrorDialog(context, 'Unexpected Error', 'An unexpected error occurred: ${e.toString()}');
      return false;
    }
  }

  Future<bool> resetPassword(BuildContext context, String email) async {
    setBusy(true);
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      setBusy(false);
      return true;
    } on FirebaseAuthException catch (e) {
      setBusy(false);
      _showErrorDialog(context, 'Password Reset Error', 'An error occurred while trying to reset the password: ${e.message}');
      return false;
    } catch (e) {
      setBusy(false);
      _showErrorDialog(context, 'Unexpected Error', 'An unexpected error occurred: ${e.toString()}');
      return false;
    }
  }

  Future<bool> createAccount(BuildContext context, String email, String password) async {
    setBusy(true);
    try {
      UserCredential userCred =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCred.user != null) {
        await FirebaseFirestore.instance.collection("users").add({
          "email": email,
          "user_uid": userCred.user!.uid,
        });
        await userCred.user!.sendEmailVerification(); // Send email verification
        setBusy(false);
        return true;
      } else {
        setBusy(false);
        return false;
      }
    } on FirebaseAuthException catch (e) {
      setBusy(false);
      if (e.code == 'weak-password') {
        _showErrorDialog(context, 'Weak Password', 'The password you entered is too weak. Please choose a stronger password.');
      } else if (e.code == 'email-already-in-use') {
        _showErrorDialog(context, 'Email Already In Use', 'The email you entered is already in use. Please use a different email.');
      } else {
        _showErrorDialog(context, 'Account Creation Error', 'An error occurred while trying to create the account: ${e.message}');
      }
      return false;
    } catch (e) {
      setBusy(false);
      _showErrorDialog(context, 'Unexpected Error', 'An unexpected error occurred: ${e.toString()}');
      return false;
    }
  }

  Future<bool> logout(BuildContext context) async {
    try {
      await _firebaseAuth.signOut();
      return true;
    } on FirebaseAuthException catch (e) {
      _showErrorDialog(context, 'Logout Error', 'An error occurred while trying to log out: ${e.message}');
      return false;
    } catch (e) {
      _showErrorDialog(context, 'Unexpected Error', 'An unexpected error occurred: ${e.toString()}');
      return false;
    }
  }

  void _showErrorDialog(BuildContext context, String title, String? description) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      title: title,
      desc: description ?? 'An unexpected error occurred',
      // btnCancelOnPress: () {},
      // btnOkOnPress: () {},
    )..show();
  }
}
