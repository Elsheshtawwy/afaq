import 'dart:math';

import 'package:afaq/widgets/Auth_widgets/MainText.dart';
import 'package:afaq/widgets/UserInfo_widgets/CustomeToggle.dart';
import 'package:afaq/widgets/buttons/CustomButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AccountTypeScree extends StatefulWidget {
  const AccountTypeScree({super.key});

  @override
  _AccountTypeScreeState createState() => _AccountTypeScreeState();
}

class _AccountTypeScreeState extends State<AccountTypeScree> {
  String _selectedUserType = "Learner";
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  int uniqueID = 0;
  bool isUnique = false;

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _saveUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String collectionName;
        switch (_selectedUserType) {
          case 'Instructor':
            collectionName = 'users';
            break;
          case 'Institute':
            collectionName = 'institutes';
            break;
          default:
            collectionName = 'users';
        }

        uniqueID = int.parse(generateRandom8DigitNumber());

        while (!isUnique) {
          final querySnapshot = await FirebaseFirestore.instance
              .collection(collectionName)
              .where('uniqueID', isEqualTo: uniqueID)
              .get();

          if (querySnapshot.docs.isEmpty) {
            isUnique = true;
          } else {
            uniqueID = int.parse(generateRandom8DigitNumber());
          }
        }

        await FirebaseFirestore.instance
            .collection(collectionName)
            .doc(user.uid)
            .set({
          'userType': _selectedUserType,
          'uniqueID': uniqueID,
        });
      }
    } catch (e) {
      debugPrint('Error saving user data: $e');
    }
  }

  String generateRandom8DigitNumber() {
    Random random = Random();
    int randomNumber = 10000000 + random.nextInt(90000000);
    return randomNumber.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final screenHeight = constraints.maxHeight;
            return Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.shade200,
                    Colors.blue.shade400,
                    Colors.blue.shade500,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: SingleChildScrollView(
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: screenHeight),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const MainText(
                              text: 'Select your account type',
                              fontSize: 24,
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            SizedBox(height: screenHeight * 0.03),
                            _buildForm(screenHeight),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildForm(double screenHeight) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: screenHeight * 0.02),
          CustomToggle(
            initialIndex: _selectedUserType == 'Learner'
                ? 0
                : (_selectedUserType == 'Instructor' ? 1 : 2),
            labels: const ['Learner', 'Instructor', 'Institute'],
            icons: const [
              FontAwesomeIcons.userGraduate,
              FontAwesomeIcons.chalkboardTeacher,
              FontAwesomeIcons.university,
            ],
            activeBgColors: const [
              [Colors.teal],
              [Colors.teal],
              [Colors.teal],
            ],
            onToggle: (index) {
              setState(() {
                _selectedUserType = index == 0
                    ? 'Learner'
                    : (index == 1 ? 'Instructor' : 'Institute');
              });
            },
          ),
          SizedBox(height: screenHeight * 0.02),
          SizedBox(height: screenHeight * 0.04),
          _isLoading
              ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                )
              : CustomButton(
                  label: 'Continue',
                  onPressed: _onContinuePressed,
                ),
        ],
      ),
    );
  }

  Future<void> _onContinuePressed() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      await _saveUserData();

      if (_selectedUserType == 'Instructor' || _selectedUserType == 'Learner') {
        Navigator.pushNamed(context, '/userInfo', arguments: _selectedUserType);
      } else {
        Navigator.pushNamed(context, '/instituteInfoScreen');
      }
    }
  }
}
