import 'package:afaq/widgets/Auth_widgets/MainText.dart';
import 'package:afaq/widgets/Auth_widgets/SubtitleText.dart';
import 'package:afaq/widgets/TextField/CustomTextField.dart';
import 'package:afaq/widgets/UserInfo_widgets/CustomeToggle.dart';
import 'package:afaq/widgets/UserInfo_widgets/DatePicker.dart';
import 'package:afaq/widgets/buttons/CustomButton.dart';
import 'package:afaq/widgets/showAwesomeDialog/showAwesomeDialog.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:io';


class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key});

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _bioController = TextEditingController();
  final _dobController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  File? _profileImage;
  String _selectedUserType = "Learner";
  String _selectedGender = "Male";

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  Future<String?> _uploadImage(File image) async {
    try {
      String formattedDate =
          DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
      Reference storageRef =
          FirebaseStorage.instance.ref('images/$formattedDate');
      await storageRef.putFile(image);
      return await storageRef.getDownloadURL();
    } catch (e) {
      debugPrint('Error uploading image: $e');
      return null;
    }
  }

  Future<void> _saveUserData(String? imageUrl) async {
    if (_fullNameController.text.isNotEmpty &&
        _phoneController.text.isNotEmpty) {
      try {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set({
            'fullName': _fullNameController.text,
            'phone': _phoneController.text,
            'profilePicture': imageUrl ?? '',
            'bio': _bioController.text,
            'userType': _selectedUserType,
            'gender': _selectedGender,
            'birthDate': _dobController.text,
          });
        }
      } catch (e) {
        debugPrint('Error saving user data: $e');
      }
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
                              text: 'Tell Us About Yourself',
                              fontSize: 28,
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            const SubtitleText(
                              text: 'You can update your profile later',
                              fontSize: 18,
                            ),
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
          GestureDetector(
            onTap: _pickImage,
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              backgroundImage:
                  _profileImage != null ? FileImage(_profileImage!) : null,
              child: _profileImage == null
                  ? Icon(
                      CupertinoIcons.photo_camera,
                      size: 50,
                      color: Colors.blue.shade600,
                    )
                  : null,
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          CustomTextField(
            controller: _fullNameController,
            labelText: 'Full Name',
            prefixIcon:
                Icon(CupertinoIcons.person, color: Colors.blue.shade600),
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
            prefixIcon: Icon(CupertinoIcons.phone, color: Colors.blue.shade600),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your phone number';
              }
              return null;
            },
          ),
          SizedBox(height: screenHeight * 0.02),
          CustomTextField(
            controller: _bioController,
            labelText: 'Bio',
            prefixIcon: Icon(CupertinoIcons.info, color: Colors.blue.shade600),
          ),
          SizedBox(height: screenHeight * 0.02),
          DatePickerWidget(
            labelText: 'Date of Birth',
            controller: _dobController,
          ),
          SizedBox(height: screenHeight * 0.02),
          CustomToggle(
            initialIndex: _selectedUserType == 'Learner' ? 0 : 1,
            labels: const ['Learner', 'Instructor'],
            icons: const [
              FontAwesomeIcons.userGraduate,
              FontAwesomeIcons.chalkboardTeacher
            ],
            activeBgColors: const [
              [Colors.teal],
              [Colors.teal]
            ],
            onToggle: (index) {
              setState(() {
                _selectedUserType = index == 0 ? 'Learner' : 'Instructor';
              });
            },
          ),
          SizedBox(height: screenHeight * 0.02),
          CustomToggle(
            initialIndex: _selectedGender == 'Male' ? 0 : 1,
            labels: const ['Male', 'Female'],
            icons: const [FontAwesomeIcons.mars, FontAwesomeIcons.venus],
            activeBgColors: const [
              [Colors.teal],
              [Colors.pink]
            ],
            onToggle: (index) {
              setState(() {
                _selectedGender = index == 0 ? 'Male' : 'Female';
              });
            },
          ),
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

      String? imageUrl;
      if (_profileImage != null) {
        imageUrl = await _uploadImage(_profileImage!);
      }

      if (imageUrl == null) {
        AwesomeDialogHelper(
            'Error',
            'An error occurred while uploading your profile picture.',
            DialogType.error);
      } else {
        await _saveUserData(imageUrl);
        setState(() {
          _isLoading = false;
        });

        Navigator.pushNamed(context, '/feed', arguments: _selectedUserType);
      }
    }
  }
}
