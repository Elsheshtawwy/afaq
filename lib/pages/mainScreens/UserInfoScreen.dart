import 'package:afaq/pages/auth/FeedScreen.dart';
import 'package:afaq/widgets/CustomTextField.dart';
import 'package:afaq/widgets/buttons/CustomButton.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class UserEditInfoScreen extends StatefulWidget {
  @override
  _UserEditInfoScreenState createState() => _UserEditInfoScreenState();
}

class _UserEditInfoScreenState extends State<UserEditInfoScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _user;
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _bioController = TextEditingController();
  String _selectedUserType = "Learner";
  String _selectedGender = "Male";
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  File? _profileImage;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    if (_user != null) {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(_user!.uid).get();
      if (userDoc.exists) {
        setState(() {
          _fullNameController.text = userDoc['fullName'];
          _phoneController.text = userDoc['phone'];
          _bioController.text = userDoc['bio'];
          _selectedUserType = userDoc['userType'];
          _selectedGender = userDoc['gender'];
        });
      }
    }
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  Future<String?> _uploadImage(File image) async {
    try {
      final storageRef = FirebaseStorage.instance.ref().child(
          'profile_pictures/${DateTime.now().millisecondsSinceEpoch}.jpg');
      final uploadTask = storageRef.putFile(image);
      final snapshot = await uploadTask.whenComplete(() => {});
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  Future<void> _updateUserInfo(String imageUrl) async {
    if (_user != null) {
      await _firestore.collection('users').doc(_user!.uid).update({
        'fullName': _fullNameController.text,
        'phone': _phoneController.text,
        'profilePicture': imageUrl,
        'bio': _bioController.text,
        'userType': _selectedUserType,
        'gender': _selectedGender,
      });
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.bottomSlide,
        title: 'Success',
        desc: 'User info updated',
        btnOkOnPress: () {},
      ).show();
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade200,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
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
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: _pickImage,
                                    child: CircleAvatar(
                                      radius: 50,
                                      backgroundColor: Colors.white,
                                      backgroundImage: _profileImage != null
                                          ? FileImage(_profileImage!)
                                          : null,
                                      child: _profileImage == null
                                          ? Icon(
                                              CupertinoIcons.photo_camera,
                                              size: 50,
                                              color: Colors.blue.shade600,
                                            )
                                          : null,
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.06),
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
                                          label: 'Update Info',
                                          onPressed: () async {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              setState(() {
                                                _isLoading = true;
                                              });

                                              String? imageUrl;
                                              if (_profileImage != null) {
                                                imageUrl = await _uploadImage(
                                                    _profileImage!);
                                              }

                                              await _updateUserInfo(
                                                  imageUrl ?? '');

                                              setState(() {
                                                _isLoading = false;
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
        DropdownMenuItem(
            value: "Institute Owner", child: Text("Institute Owner")),
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
