import 'package:afaq/helpers/functions.dart';
import 'package:afaq/pages/mainScreens/MyProfile.dart';
import 'package:afaq/widgets/TextField/CustomTextField.dart';
import 'package:afaq/widgets/UserInfo_widgets/CustomeToggle.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
          _bioController.text = userDoc['birthDate'];
          _selectedUserType = userDoc['userType'];
          _selectedGender = userDoc['gender'];
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
    } else {
      print('No image selected.');
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
        'dob': _dobController.text,
        'email': _emailController.text,
        'student': _studentController.text,
      });
      await updateAuthEmail(
        _emailController.text,
      );

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

  Future<void> updateAuthEmail(String newEmail) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Send verification email
        await user.sendEmailVerification();

        // Update email after verification
        await user.verifyBeforeUpdateEmail(newEmail);
        await user.updateEmail(newEmail);
        await user.reload();
        user = FirebaseAuth.instance.currentUser;
        print("Email updated successfully in Authentication");
      }
    } catch (e) {
      print("Error updating email in Authentication: $e");
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    _dobController.dispose();
    _emailController.dispose();
    _studentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = getSize(context).width;
    final screenHeight = getSize(context).height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0,
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
          vertical: screenHeight * 0.02,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildProfileImage(screenWidth),
              SizedBox(height: screenHeight * 0.03),
              _buildFormFields(screenWidth, screenHeight),
              SizedBox(height: screenHeight * 0.03),
              _isLoading
                  ? const CircularProgressIndicator()
                  : _buildUpdateButton(screenWidth, screenHeight),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImage(double screenWidth) {
    return Stack(
      children: [
        const ProfilePicture(),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: _pickImage,
            child: CircleAvatar(
              radius: screenWidth * 0.05,
              backgroundColor: Colors.white,
              child: Icon(Icons.camera_alt, color: Colors.teal[800]),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFormFields(double screenWidth, double screenHeight) {
    return Column(
      children: [
        CustomTextField(
          controller: _fullNameController,
          labelText: 'Full Name',
        ),
        SizedBox(height: screenHeight * 0.02),
        _buildDatePicker(screenWidth, screenHeight),
        SizedBox(height: screenHeight * 0.02),
        CustomTextField(
          controller: _emailController,
          labelText: 'Email',
          prefixIcon: const Icon(Icons.email),
        ),
        SizedBox(height: screenHeight * 0.02),
        CustomTextField(
          controller: _phoneController,
          labelText: 'Phone Number',
          prefixIcon: const Icon(Icons.flag, color: Colors.red),
        ),
        SizedBox(height: screenHeight * 0.02),
        CustomTextField(
          controller: _bioController,
          labelText: 'Bio',
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
      ],
    );
  }

  Widget _buildDatePicker(double screenWidth, double screenHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: screenHeight * 0.01),
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
              suffixIcon: const Icon(Icons.calendar_today),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUpdateButton(double screenWidth, double screenHeight) {
    return ElevatedButton.icon(
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
        backgroundColor: Colors.teal,
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.1,
          vertical: screenHeight * 0.02,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      icon: const Icon(
        Icons.update,
        color: Colors.white,
        size: 20,
      ),
      label: const Text(
        'Update',
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}
