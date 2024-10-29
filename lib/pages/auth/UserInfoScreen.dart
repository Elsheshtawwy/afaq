import 'package:afaq/widgets/TextField/CustomTextField.dart';
import 'package:afaq/widgets/buttons/CustomButton.dart';
import 'package:afaq/widgets/showAwesomeDialog/showAwesomeDialog.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
                    Colors.blue.shade500,
                    Colors.blue.shade600,
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
          _buildDropdownButtonFormField(),
          SizedBox(height: screenHeight * 0.02),
          CustomTextField(
            controller: _bioController,
            labelText: 'Bio',
            prefixIcon: Icon(CupertinoIcons.info, color: Colors.blue.shade600),
          ),
          SizedBox(height: screenHeight * 0.02),
          _buildGenderDropdown(),
          SizedBox(height: screenHeight * 0.02),
          _buildDatePicker(),
          SizedBox(height: screenHeight * 0.04),
          _isLoading
              ? const CircularProgressIndicator()
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

  Widget _buildDatePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: _dobController.text.isNotEmpty
                  ? DateTime.parse(_dobController.text)
                  : DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            if (pickedDate != null) {
              setState(() {
                _dobController.text = pickedDate.toString().split(' ')[0];
              });
            }
          },
          child: AbsorbPointer(
            child: CustomTextField(
              controller: _dobController,
              labelText: 'Birth Date',
              prefixIcon:
                  Icon(Icons.calendar_today, color: Colors.blue.shade600),
            ),
          ),
        ),
      ],
    );
  }
}