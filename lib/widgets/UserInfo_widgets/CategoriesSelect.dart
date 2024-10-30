import 'package:afaq/models/CategoryModel.dart';
import 'package:flutter/material.dart';

class CategoriesSelect extends StatelessWidget {
  final List<CategoryModel> interests;
  final List<CategoryModel> selectedInterests;
  final Function(CategoryModel) onInterestSelected;
  final Function(CategoryModel) onInterestRemoved;
  final Widget preferencesDropdown;

  const CategoriesSelect({
    super.key,
    required this.interests,
    required this.selectedInterests,
    required this.onInterestSelected,
    required this.onInterestRemoved,
    required this.preferencesDropdown,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        const Text(
          'Choose your interests:',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        DropdownButtonFormField<CategoryModel>(
          items: interests.map((interest) {
            return DropdownMenuItem<CategoryModel>(
              value: interest,
              child: Row(
                children: [
                  Image.asset(
                    interest.imageUrl,
                    width: 24,
                    height: 24,
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                  Text(
                    interest.name.toString(),
                    style: const TextStyle(color: Colors.black),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: (CategoryModel? value) {
            if (value != null) {
              onInterestSelected(value);
            }
          },
          decoration: InputDecoration(
            labelText: 'Select Interests',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
        Wrap(
          children: selectedInterests.map((interest) {
            return Chip(
              label: Text(interest.name),
              onDeleted: () {
                onInterestRemoved(interest);
              },
            );
          }).toList(),
        ),
        SizedBox(height: screenHeight * 0.02),
        preferencesDropdown,
      ],
    );
  }
}