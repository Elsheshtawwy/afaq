import 'package:afaq/models/CategoryModel.dart';
import 'package:afaq/pages/Onboarding/onboardingScreen.dart';
import 'package:afaq/widgets/Auth_widgets/MainText.dart';
import 'package:afaq/widgets/Auth_widgets/SubtitleText.dart';
import 'package:afaq/widgets/UserInfo_widgets/InstructorFormFields.dart';
import 'package:afaq/widgets/UserInfo_widgets/StudentFormFields.dart';
import 'package:afaq/widgets/buttons/CustomButton.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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
  final List<CategoryModel> _interests = getInterests();
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

    _checkAccountStatus();
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
      await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
        'preferences': _selectedInterests.map((e) => e.name).toList(),
        'preferenceType': _selectedPreference,
      });
    }
  }

  Future<void> _checkAccountStatus() async {
    await Future.delayed(const Duration(seconds: 1));
    bool emailVerified = await _fetchEmailVerificationStatus();
    setState(() {
      _isEmailVerified = emailVerified;
    });
  }

  Future<bool> _fetchEmailVerificationStatus() async {
    if (user != null) {
      await user!.reload();
      return user!.emailVerified;
    }
    return false;
  }

  Widget _buildPreferencesDropdown() {
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

      bool emailVerified = await _fetchEmailVerificationStatus();
      setState(() {
        _isEmailVerified = emailVerified;
      });

      if (_isEmailVerified) {
        await _savePreferencesToFirestore();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const OnboardingScreen(),
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
                                    StudentFormFields(
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
                                          _buildPreferencesDropdown(),
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

List<CategoryModel> getInterests() {
  return [
    CategoryModel(id: "0", name: 'Arabic', imageUrl: 'assets/icons/arabic.png'),
    CategoryModel(
        id: "1",
        name: 'Artificial Intelligence',
        imageUrl: 'assets/icons/artificialintelligence.png'),
    CategoryModel(
        id: "2", name: 'Biology', imageUrl: 'assets/icons/Biology.png'),
    CategoryModel(
        id: "3",
        name: 'Business Law',
        imageUrl: 'assets/icons/businessLaw.png'),
    CategoryModel(
        id: "4",
        name: 'Car Mechanics',
        imageUrl: 'assets/icons/carMechanics.png'),
    CategoryModel(
        id: "5", name: 'Chemistry', imageUrl: 'assets/icons/Chemistry.png'),
    CategoryModel(
        id: "6",
        name: 'Communication Skills',
        imageUrl: 'assets/icons/communicationSkills.png'),
    CategoryModel(
        id: "7",
        name: 'Cybersecurity',
        imageUrl: 'assets/icons/cybersecurity.png'),
    CategoryModel(
        id: "8",
        name: 'Digital Marketing',
        imageUrl: 'assets/icons/digitalMarketing.png'),
    CategoryModel(
        id: "9", name: 'English', imageUrl: 'assets/icons/English.png'),
    CategoryModel(
        id: "10",
        name: 'Electricity',
        imageUrl: 'assets/icons/electricity.png'),
    CategoryModel(
        id: "11", name: 'Fitness', imageUrl: 'assets/icons/fitness.png'),
    CategoryModel(
        id: "12", name: 'German', imageUrl: 'assets/icons/germany.png'),
    CategoryModel(
        id: "13",
        name: 'Human Resources',
        imageUrl: 'assets/icons/humanResources.png'),
    CategoryModel(
        id: "14",
        name: 'Interior Design',
        imageUrl: 'assets/icons/interiorDesign.png'),
    CategoryModel(
        id: "15", name: 'Leadership', imageUrl: 'assets/icons/leadership.png'),
    CategoryModel(
        id: "16",
        name: 'Mathematics',
        imageUrl: 'assets/icons/mathematics.png'),
    CategoryModel(
        id: "17", name: 'Nursing', imageUrl: 'assets/icons/nursing.png'),
    CategoryModel(
        id: "18", name: 'Nutrition', imageUrl: 'assets/icons/nutrition.png'),
    CategoryModel(
        id: "19", name: 'Painting', imageUrl: 'assets/icons/painting.png'),
    CategoryModel(
        id: "20",
        name: 'Personal Finance',
        imageUrl: 'assets/icons/personalFinance.png'),
    CategoryModel(
        id: "21", name: 'Physics', imageUrl: 'assets/icons/Physics.png'),
    CategoryModel(
        id: "22",
        name: 'Playing Instruments',
        imageUrl: 'assets/icons/playingInstruments.png'),
    CategoryModel(
        id: "23", name: 'Pottery', imageUrl: 'assets/icons/pottery.png'),
    CategoryModel(
        id: "24",
        name: 'Programming',
        imageUrl: 'assets/icons/programming.png'),
    CategoryModel(
        id: "25",
        name: 'Project Management',
        imageUrl: 'assets/icons/projectManagement.png'),
    CategoryModel(
        id: "26",
        name: 'Time Management',
        imageUrl: 'assets/icons/timeManagement.png'),
    CategoryModel(
        id: "27",
        name: 'Web Development',
        imageUrl: 'assets/icons/webDevelopment.png'),
    CategoryModel(
        id: "28",
        name: 'Woodworking',
        imageUrl: 'assets/icons/woodworking.png'),
  ];
}
