import 'dart:io';

import 'package:afaq/widgets/TextField/CustomTextField.dart';
import 'package:afaq/models/CategoryModel.dart';
import 'package:afaq/widgets/UserInfo_widgets/CategoriesSelect.dart';
import 'package:afaq/widgets/buttons/CustomButton.dart';
import 'package:afaq/widgets/data/data.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddCourseScreen extends StatefulWidget {
  const AddCourseScreen({super.key});

  @override
  _AddCourseScreenState createState() => _AddCourseScreenState();
}

class _AddCourseScreenState extends State<AddCourseScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  File? _imageUrl;

  final title = TextEditingController();
  final description = TextEditingController();
  final startDate = TextEditingController();
  final endDate = TextEditingController();
  final category = TextEditingController();
  final subtitle = TextEditingController();
  final price = TextEditingController();
  final oldPrice = TextEditingController();
  final classes = TextEditingController();
  final hours = TextEditingController();
  final about = TextEditingController();
  final features = TextEditingController();
  final objectives = TextEditingController();
  final requirements = TextEditingController();
  final lessons = TextEditingController();
  final currentStudents = TextEditingController();
  final targetStudents = TextEditingController();
  final level = TextEditingController();
  final isOnline = TextEditingController();
  final instructors = TextEditingController();
  final address = TextEditingController();
  final uniqueID = TextEditingController();

  final List<CategoryModel> _interests = dataClass().getInterests();
  List<CategoryModel> _selectedInterests = [];
  String _selectedPreference = "Academic Courses";

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  void _disposeControllers() {
    title.dispose();
    description.dispose();
    startDate.dispose();
    endDate.dispose();
    category.dispose();
    subtitle.dispose();
    price.dispose();
    oldPrice.dispose();
    classes.dispose();
    hours.dispose();
    about.dispose();
    features.dispose();
    objectives.dispose();
    requirements.dispose();
    lessons.dispose();
    currentStudents.dispose();
    targetStudents.dispose();
    level.dispose();
    isOnline.dispose();
    instructors.dispose();
    address.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageUrl = File(pickedFile.path);
      });
    }
  }

  Future<String?> _uploadImage(File image) async {
    try {
      String formattedDate =
          DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
      Reference storageRef =
          FirebaseStorage.instance.ref().child('courses/$formattedDate');
      final uploadTask = await storageRef.putFile(image);

      if (uploadTask.state == TaskState.success) {
        return await storageRef.getDownloadURL();
      } else {
        debugPrint('Error uploading image: ${uploadTask.state}');
        return null;
      }
    } catch (e) {
      debugPrint('Error uploading image: $e');
      return null;
    }
  }

Future<void> _saveCourseData(String? imageUrl) async {
  final user = FirebaseAuth.instance.currentUser;
  final uid = user!.uid;
  DocumentSnapshot userDoc = await FirebaseFirestore.instance
      .collection('institutes')
      .doc(uid)
      .get();
  setState(() {
    uniqueID.text = userDoc['uniqueID'].toString(); 
  });

  try {
    final courseData = {
      'title': title.text,
      'description': description.text,
      'startDate': startDate.text,
      'endDate': endDate.text,
      'category': _selectedInterests.map((e) => e.name).toList(), 
      'subtitle': subtitle.text,
      'price': double.tryParse(price.text) ?? 0.0,
      'oldPrice': double.tryParse(oldPrice.text) ?? 0.0,
      'imageUrl': imageUrl,
      'classes': int.tryParse(classes.text) ?? 0,
      'hours': int.tryParse(hours.text) ?? 0,
      'about': about.text,
      'features': features.text,
      'objectives': objectives.text,
      'requirements': requirements.text,
      'lessons': lessons.text,
      'currentStudents': currentStudents.text,
      'targetStudents': targetStudents.text,
      'level': level.text,
      'isOnline': isOnline.text,
      'instructors': instructors.text,
      'address': address.text,
      'institutesID': uniqueID.text,
    };

    await FirebaseFirestore.instance.collection('courses').add(courseData);
  } catch (e) {
    debugPrint('Error saving course data: $e');
    _showAwesomeDialog('Error',
        'An error occurred while saving the course data.', DialogType.error);
  }
}



  void _showAwesomeDialog(String title, String message, DialogType dialogType) {
    AwesomeDialog(
      context: context,
      dialogType: dialogType,
      animType: AnimType.bottomSlide,
      title: title,
      desc: message,
      btnOkOnPress: () {},
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade600,
      appBar: AppBar(
        title: const Text('Add Course'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final screenHeight = constraints.maxHeight;

            return Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(),
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
                              'Add a New Course',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.03),
                            const Text(
                              'Fill in the details below.',
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
            backgroundImage: _imageUrl != null ? FileImage(_imageUrl!) : null,
            child: _imageUrl == null
                ? Icon(
                    CupertinoIcons.photo_camera,
                    size: 50,
                    color: Colors.blue.shade600,
                  )
                : null,
          ),
        ),
        SizedBox(height: screenHeight * 0.02),
        _buildCustomTextField(title, 'Course Title', CupertinoIcons.book),
        SizedBox(height: screenHeight * 0.02),
        _buildCustomTextField(description, 'Description', CupertinoIcons.text_alignleft),
        SizedBox(height: screenHeight * 0.02),
        _buildDatePicker(startDate, 'Start Date'),
        SizedBox(height: screenHeight * 0.02),
        _buildDatePicker(endDate, 'End Date'),
        SizedBox(height: screenHeight * 0.02),
        _buildCustomTextField(category, 'Category', CupertinoIcons.tag),
        SizedBox(height: screenHeight * 0.02),
        CategoriesSelect(
          interests: _interests,
          selectedInterests: _selectedInterests,
          onInterestSelected: (interest) {
            setState(() {
              if (!_selectedInterests.contains(interest)) {
                _selectedInterests.add(interest);
              }
            });
          },
          onInterestRemoved: (interest) {
            setState(() {
              _selectedInterests.remove(interest);
            });
          },
          preferencesDropdown: buildPreferencesDropdown(),
        ),
        SizedBox(height: screenHeight * 0.02),
        _buildCustomTextField(price, 'Price', CupertinoIcons.money_dollar, TextInputType.number),
        SizedBox(height: screenHeight * 0.02),
        _buildCustomTextField(oldPrice, 'Old Price', CupertinoIcons.money_dollar, TextInputType.number),
        SizedBox(height: screenHeight * 0.02),
        _buildCustomTextField(subtitle, 'Subtitle', CupertinoIcons.textformat),
        SizedBox(height: screenHeight * 0.02),
        _buildCustomTextField(classes, 'Classes', CupertinoIcons.number, TextInputType.number),
        SizedBox(height: screenHeight * 0.02),
        _buildCustomTextField(hours, 'Hours', CupertinoIcons.time, TextInputType.number),
        SizedBox(height: screenHeight * 0.02),
        _buildCustomTextField(about, 'About', CupertinoIcons.info),
        SizedBox(height: screenHeight * 0.02),
        _buildCustomTextField(features, 'Features', CupertinoIcons.star),
        SizedBox(height: screenHeight * 0.02),
        SizedBox(height: screenHeight * 0.02),
        _buildCustomTextField(objectives, 'Objectives', CupertinoIcons.checkmark_seal),
        SizedBox(height: screenHeight * 0.02),
        _buildCustomTextField(requirements, 'Requirements', CupertinoIcons.doc_text),
        SizedBox(height: screenHeight * 0.02),
        _buildCustomTextField(lessons, 'Lessons', CupertinoIcons.book),
        SizedBox(height: screenHeight * 0.02),
        _buildCustomTextField(currentStudents, 'Current Students', CupertinoIcons.person_2, TextInputType.number),
        SizedBox(height: screenHeight * 0.02),
        _buildCustomTextField(targetStudents, 'Target Students', CupertinoIcons.person_3, TextInputType.number),
        SizedBox(height: screenHeight * 0.02),
        _buildCustomTextField(level, 'Level', Icons.stairs),
        SizedBox(height: screenHeight * 0.02),
        _buildCustomTextField(isOnline, 'Is Online', CupertinoIcons.wifi),
        SizedBox(height: screenHeight * 0.02),
        _buildCustomTextField(instructors, 'Instructors', CupertinoIcons.person),
        SizedBox(height: screenHeight * 0.02),
        _buildCustomTextField(address, 'Address', CupertinoIcons.location),
        SizedBox(height: screenHeight * 0.02),
        _isLoading
            ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
              )
            : CustomButton(
                label: 'Save Course',
                onPressed: _onSaveCoursePressed,
              ),
      ],
    ),
  );
}


  Widget _buildCustomTextField(
      TextEditingController controller, String labelText, IconData icon,
      [TextInputType keyboardType = TextInputType.text]) {
    return CustomTextField(
      controller: controller,
      labelText: labelText,
      prefixIcon: Icon(icon, color: Colors.blue.shade600),
      keyboardType: keyboardType,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $labelText';
        }
        return null;
      },
    );
  }

  Widget _buildDatePicker(TextEditingController controller, String labelText) {
    return GestureDetector(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: controller.text.isNotEmpty
              ? DateTime.parse(controller.text)
              : DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) {
          setState(() {
            controller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
          });
        }
      },
      child: AbsorbPointer(
        child: CustomTextField(
          controller: controller,
          labelText: labelText,
          prefixIcon:
              Icon(CupertinoIcons.calendar, color: Colors.blue.shade600),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select $labelText';
            }
            return null;
          },
        ),
      ),
    );
  }

  Future<void> _onSaveCoursePressed() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      String? imageUrl;
      if (_imageUrl != null) {
        imageUrl = await _uploadImage(_imageUrl!);
      }

      if (imageUrl == null) {
        _showAwesomeDialog(
            'Error',
            'An error occurred while uploading the course image.',
            DialogType.error);
      } else {
        await _saveCourseData(imageUrl);

        setState(() {
          _isLoading = false;
        });

        Navigator.pop(context);
      }
    }
  }
}
