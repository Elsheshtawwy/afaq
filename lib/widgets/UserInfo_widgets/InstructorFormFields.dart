import 'package:afaq/widgets/TextField/CustomTextField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InstructorFormFields extends StatelessWidget {
  final TextEditingController specializationController;
  final TextEditingController qualificationsController;
  final TextEditingController experiencesController;

  const InstructorFormFields({
    super.key,
    required this.specializationController,
    required this.qualificationsController,
    required this.experiencesController,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        CustomTextField(
          controller: specializationController,
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
          controller: qualificationsController,
          labelText: 'Qualifications',
          prefixIcon: Icon(CupertinoIcons.book, color: Colors.blue.shade600),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your qualifications';
            }
            return null;
          },
        ),
        SizedBox(height: screenHeight * 0.02),
        CustomTextField(
          controller: experiencesController,
          labelText: 'Experiences',
          prefixIcon: Icon(CupertinoIcons.briefcase_fill,
              color: Colors.blue.shade600),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your experiences';
            }
            return null;
          },
        ),
      ],
    );
  }
}