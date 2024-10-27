import 'package:afaq/pages/mainScreens/MyProfile.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _user;
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _bioController = TextEditingController();
  final _nickNameController = TextEditingController();
  final _dobController = TextEditingController();
  final _emailController = TextEditingController();
  final _studentController = TextEditingController();
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
          _nickNameController.text = userDoc['nickName'];
          _dobController.text = userDoc['dob'];
          _emailController.text = userDoc['email'];
          _studentController.text = userDoc['student'];
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
        'nickName': _nickNameController.text,
        'dob': _dobController.text,
        'email': _emailController.text,
        'student': _studentController.text,
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
    _nickNameController.dispose();
    _dobController.dispose();
    _emailController.dispose();
    _studentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: _profileImage != null
                        ? FileImage(_profileImage!)
                        : NetworkImage(_user?.photoURL ?? '') as ImageProvider,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.camera_alt, color: Colors.teal[800]),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Form Fields
              CustomTextField(
                controller: _fullNameController,
                labelText: 'Full Name',
              ),
              CustomTextField(
                controller: _nickNameController,
                labelText: 'Nick Name',
              ),
              CustomTextField(
                controller: _dobController,
                labelText: 'Date of Birth',
                icon: Icons.calendar_today,
              ),
              CustomTextField(
                controller: _emailController,
                labelText: 'Email',
                icon: Icons.email,
              ),
              CustomTextField(
                controller: _phoneController,
                labelText: 'Phone Number',
                prefixIcon: const Icon(Icons.flag, color: Colors.red),
              ),
              CustomDropdownField(
                labelText: 'Gender',
                value: _selectedGender,
                items: const ['Male', 'Female', 'Other'],
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value ?? "Male";
                  });
                },
              ),
              CustomTextField(
                controller: _studentController,
                labelText: 'Student',
              ),

              const SizedBox(height: 24),

              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _isLoading = true;
                          });

                          String? imageUrl;
                          if (_profileImage != null) {
                            imageUrl = await _uploadImage(_profileImage!);
                          }

                          await _updateUserInfo(imageUrl ?? '');

                          setState(() {
                            _isLoading = false;
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding:
                            const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Update',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom TextField Widget
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData? icon;
  final Widget? prefixIcon;

  const CustomTextField(
      {super.key, required this.controller,
      required this.labelText,
      this.icon,
      this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(fontSize: 14),
          prefixIcon: prefixIcon,
          suffixIcon: icon != null ? Icon(icon) : null,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        ),
      ),
    );
  }
}

// Custom Dropdown Field Widget
class CustomDropdownField extends StatelessWidget {
  final String labelText;
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const CustomDropdownField(
      {super.key, required this.labelText,
      required this.value,
      required this.items,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(fontSize: 14),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            value: value,
            hint: const Text(
              'Select',
              style: TextStyle(fontSize: 14),
            ),
            items: items.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}
