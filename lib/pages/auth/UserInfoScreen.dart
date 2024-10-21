import 'package:afaq/pages/auth/FeedScreen.dart';
import 'package:afaq/widgets/CustomTextField.dart';
import 'package:afaq/widgets/buttons/CustomButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key});

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _profilePictureController = TextEditingController();
  final _bioController = TextEditingController();
  String _selectedUserType = "Learner";
  String _selectedGender = "Male";
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _profilePictureController.dispose();
    _bioController.dispose();
    super.dispose();
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
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.03),
                            const Text(
                              'You can change this information later.',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white70,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.03),
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  CustomTextField(
                                    controller: _fullNameController,
                                    labelText: 'Full Name',
                                    prefixIcon: Icon(CupertinoIcons.person,
                                        color: Colors.blue.shade600),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your full name';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: screenHeight * 0.02),
                                  CustomTextField(
                                    controller: _phoneController,
                                    labelText: 'Phone Number',
                                    keyboardType: TextInputType.phone,
                                    prefixIcon: Icon(CupertinoIcons.phone,
                                        color: Colors.blue.shade600),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your phone number';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: screenHeight * 0.02),
                                  _buildDropdownButtonFormField(),
                                  SizedBox(height: screenHeight * 0.02),
                                  CustomTextField(
                                    controller: _profilePictureController,
                                    labelText: 'Profile Picture URL',
                                    prefixIcon: Icon(CupertinoIcons.photo,
                                        color: Colors.blue.shade600),
                                  ),
                                  SizedBox(height: screenHeight * 0.02),
                                  CustomTextField(
                                    controller: _bioController,
                                    labelText: 'Bio',
                                    prefixIcon: Icon(CupertinoIcons.info,
                                        color: Colors.blue.shade600),
                                  ),
                                  SizedBox(height: screenHeight * 0.02),
                                  _buildGenderDropdown(),
                                  SizedBox(height: screenHeight * 0.04),
                                  _isLoading
                                      ? const CircularProgressIndicator()
                                      : CustomButton(
                                          label: 'Continue',
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              setState(() {
                                                _isLoading = true;
                                              });
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        FeedScreen(
                                                      selectedUserType:
                                                          _selectedUserType,
                                                    ),
                                                  ));
                                              Future.delayed(
                                                  const Duration(seconds: 2),
                                                  () {
                                                setState(() {
                                                  _isLoading = false;
                                                });
                                              });
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

  Widget _buildDropdownButtonFormField() {
    return DropdownButtonFormField<String>(
      value: _selectedUserType,
      items: const [
        DropdownMenuItem(value: "Learner", child: Text("Learner")),
        DropdownMenuItem(value: "Instructor", child: Text("Instructor")),
      ],
      onChanged: (value) {
        setState(() {
          _selectedUserType = value ?? "Learner";
        });
      },
      decoration: InputDecoration(
        labelText: 'Select Your Role',
        prefixIcon:
            Icon(CupertinoIcons.person_2_fill, color: Colors.blue.shade600),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  Widget _buildGenderDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedGender,
      items: const [
        DropdownMenuItem(value: "Male", child: Text("Male")),
        DropdownMenuItem(value: "Female", child: Text("Female")),
        DropdownMenuItem(value: "Other", child: Text("Other")),
      ],
      onChanged: (value) {
        setState(() {
          _selectedGender = value ?? "Male";
        });
      },
      decoration: InputDecoration(
        labelText: 'Gender',
        prefixIcon: Icon(CupertinoIcons.person, color: Colors.blue.shade600),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
