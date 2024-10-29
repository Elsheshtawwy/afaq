import 'package:afaq/pages/Onboarding/onboardingScreen.dart';
import 'package:afaq/widgets/TextField/CustomTextField.dart';
import 'package:afaq/widgets/buttons/CustomButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  late List<String> _interests;
  String _selectedPreference = "Academic Courses";
  bool _isEmailVerified = false;

  @override
  void initState() {
    super.initState();
    _selectedUserType = widget.selectedUserType;

    if (_selectedUserType == 'Instructor') {
      _specializationController = TextEditingController();
      _qualificationsController = TextEditingController();
      _experiencesController = TextEditingController();
    } else {
      _interests = [];
    }
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

  Future<bool> _checkAccountStatus() async {
    await Future.delayed(const Duration(seconds: 1));

 bool emailVerified = await _fetchEmailVerificationStatus();

    setState(() {
      _isEmailVerified = emailVerified;
    });

    return _isEmailVerified;
  }

  Future<bool> _fetchEmailVerificationStatus() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      await user.reload(); 
      return user.emailVerified; 
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
        prefixIcon: Icon(CupertinoIcons.settings, color: Colors.blue.shade600),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = constraints.maxWidth;
            final screenHeight = constraints.maxHeight;

            return Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.shade200,
                    Colors.blue.shade500,
                    Colors.blue.shade600
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
                            const Text(
                              'Tell us more about you!',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.03),
                            const Text(
                              'You can change this information later.',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.03),
                            Form(
                              child: Column(
                                children: [
                                  if (_selectedUserType == 'Instructor') ...[
                                    CustomTextField(
                                      controller: _specializationController,
                                      labelText: 'Specialization',
                                      prefixIcon: Icon(CupertinoIcons.briefcase,
                                          color: Colors.blue.shade600),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your specialization';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: screenHeight * 0.02),
                                    CustomTextField(
                                      controller: _qualificationsController,
                                      labelText: 'Qualifications',
                                      prefixIcon: Icon(CupertinoIcons.book,
                                          color: Colors.blue.shade600),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your qualifications';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: screenHeight * 0.02),
                                    CustomTextField(
                                      controller: _experiencesController,
                                      labelText: 'Experiences',
                                      prefixIcon: Icon(
                                          CupertinoIcons.briefcase_fill,
                                          color: Colors.blue.shade600),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your experiences';
                                        }
                                        return null;
                                      },
                                    ),
                                  ] else ...[
                                    const Text(
                                      'Choose your interests:',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white70,
                                      ),
                                    ),
                                    CheckboxListTile(
                                      title: const Text('Interest 1'),
                                      value: _interests.contains('Interest 1'),
                                      onChanged: (bool? value) {
                                        setState(() {
                                          if (value == true) {
                                            _interests.add('Interest 1');
                                          } else {
                                            _interests.remove('Interest 1');
                                          }
                                        });
                                      },
                                      activeColor: Colors.blue.shade600,
                                      checkColor: Colors.white,
                                      tileColor: Colors.white.withOpacity(0.1),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    CheckboxListTile(
                                      title: const Text('Interest 2'),
                                      value: _interests.contains('Interest 2'),
                                      onChanged: (bool? value) {
                                        setState(() {
                                          if (value == true) {
                                            _interests.add('Interest 2');
                                          } else {
                                            _interests.remove('Interest 2');
                                          }
                                        });
                                      },
                                      activeColor: Colors.blue.shade600,
                                      checkColor: Colors.white,
                                      tileColor: Colors.white.withOpacity(0.1),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    SizedBox(height: screenHeight * 0.02),
                                    _buildPreferencesDropdown(),
                                  ],
                                  SizedBox(height: screenHeight * 0.04),
                                  _isLoading
                                      ? const CircularProgressIndicator()
                                      : CustomButton(
                                          label: 'Continue',
                                          onPressed: () async {
                                            setState(() {
                                              _isLoading = true;
                                            });

                                            bool isAccountValid =
                                                await _checkAccountStatus();

                                            setState(() {
                                              _isLoading = false;
                                            });

                                            if (isAccountValid) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                       const OnboardingScreen(),
                                                ),
                                              );
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      'Please verify your email first.'),
                                                ),
                                              );
                                            }
                                          },
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
