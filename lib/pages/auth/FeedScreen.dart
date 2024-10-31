import 'package:afaq/models/CategoryModel.dart';
import 'package:afaq/pages/Onboarding/onboardingScreen.dart';
import 'package:afaq/pages/mainScreens/home_screen.dart';
import 'package:afaq/providers/user_data_provider.dart';
import 'package:afaq/widgets/Auth_widgets/MainText.dart';
import 'package:afaq/widgets/Auth_widgets/SubtitleText.dart';
import 'package:afaq/widgets/UserInfo_widgets/CategoriesSelect.dart';
import 'package:afaq/widgets/UserInfo_widgets/InstructorFormFields.dart';
import 'package:afaq/widgets/buttons/CustomButton.dart';
import 'package:afaq/widgets/data/data.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FeedScreen extends StatefulWidget {
  final String selectedUserType;

  const FeedScreen({super.key, required this.selectedUserType});

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  bool _isLoading = false;
  late String _selectedUserType;
  late TextEditingController _specializationController;
  late TextEditingController _qualificationsController;
  late TextEditingController _experiencesController;
  final List<CategoryModel> _interests = dataClass().getInterests();
  final List<CategoryModel> _selectedInterests = [];
  String _selectedPreference = "Academic Courses";
  bool _isEmailVerified = false;
  final _formKey = GlobalKey<FormState>();
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _selectedUserType = widget.selectedUserType;

    if (_selectedUserType == 'Instructor') {
      _specializationController = TextEditingController();
      _qualificationsController = TextEditingController();
      _experiencesController = TextEditingController();
    }

    UserDataProvider().checkAccountStatus();
  }

  @override
  void dispose() {
    if (_selectedUserType == 'Instructor') {
      _specializationController.dispose();
      _qualificationsController.dispose();
      _experiencesController.dispose();
    }
    super.dispose();
  }

  Future<void> _savePreferencesToFirestore() async {
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'preferences': _selectedInterests.map((e) => e.name).toList(),
        'preferenceType': _selectedPreference,
        'email': FirebaseAuth.instance.currentUser!.email,
      });
    }
  }

  Widget buildPreferencesDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedPreference,
      items: const [
        DropdownMenuItem(
          value: "Academic Courses",
          child: Text(
            "Academic Courses",
            style: TextStyle(fontSize: 14),
          ),
        ),
        DropdownMenuItem(
          value: "Vocational/Professional Courses",
          child: Text(
            "Vocational/Professional Courses",
            style: TextStyle(fontSize: 14),
          ),
        ),
      ],
      onChanged: (value) {
        setState(() {
          _selectedPreference = value ?? "Academic Courses";
        });
      },
      decoration: InputDecoration(
        labelText: 'Preferences',
        prefixIcon: Icon(FontAwesomeIcons.book, color: Colors.blue.shade600),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  Future<void> _onContinuePressed() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      bool emailVerified =
          await UserDataProvider().fetchEmailVerificationStatus();
      setState(() {
        _isEmailVerified = emailVerified;
      });

      if (_isEmailVerified) {
        await _savePreferencesToFirestore();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.info,
          animType: AnimType.bottomSlide,
          title: 'Email not verified',
          desc: 'Please verify your email before proceeding.',
          btnCancelOnPress: () {},
          btnCancelText: 'OK',
          btnCancelColor: Colors.red,
        ).show();
      }

      setState(() {
        _isLoading = false;
      });
    }
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
                    Colors.blue.shade500
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: SingleChildScrollView(
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: screenHeight,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const MainText(
                              text: 'Tell us more about you!',
                              fontSize: 24,
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            const SubtitleText(
                              text: 'You can change this information later.',
                              fontSize: 18,
                            ),
                            SizedBox(height: screenHeight * 0.03),
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  if (_selectedUserType == 'Instructor')
                                    InstructorFormFields(
                                      specializationController:
                                          _specializationController,
                                      qualificationsController:
                                          _qualificationsController,
                                      experiencesController:
                                          _experiencesController,
                                    )
                                  else
                                    CategoriesSelect(
                                      interests: _interests,
                                      selectedInterests: _selectedInterests,
                                      onInterestSelected: (interest) {
                                        setState(() {
                                          if (!_selectedInterests
                                              .contains(interest)) {
                                            _selectedInterests.add(interest);
                                          }
                                        });
                                      },
                                      onInterestRemoved: (interest) {
                                        setState(() {
                                          _selectedInterests.remove(interest);
                                        });
                                      },
                                      preferencesDropdown:
                                          buildPreferencesDropdown(),
                                    ),
                                  SizedBox(height: screenHeight * 0.04),
                                  _isLoading
                                      ? const CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation(
                                              Colors.white),
                                        )
                                      : CustomButton(
                                          label: 'Continue',
                                          onPressed: _onContinuePressed,
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
              ),
            );
          },
        ),
      ),
    );
  }
}
