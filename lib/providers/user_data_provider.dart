import 'package:afaq/providers/base_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserDataProvider with ChangeNotifier {
  final BaseProvider _baseProvider = BaseProvider();

  UserDataProvider();

  Future<String?> getProfilePicture(String userId) async {
    try {
      _baseProvider.setBusy(true);
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      _baseProvider.setBusy(false);
      return userDoc.get('profilePicture') as String?;
    } catch (e) {
      print('Error fetching profile picture: $e');
      _baseProvider.setBusy(false);
      return null;
    }
  }

  Future<void> checkAccountStatus() async {
    await Future.delayed(const Duration(seconds: 1));
    bool emailVerified = await fetchEmailVerificationStatus();
    notifyListeners();
  }

  Future<bool> fetchEmailVerificationStatus() async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.reload();
      notifyListeners();

      return user.emailVerified;
    }
    return false;
  }
}
