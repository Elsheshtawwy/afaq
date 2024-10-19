import 'package:afaq/widgets/cards/instituteCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class InstitutesScreen extends StatelessWidget {
  const InstitutesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            'Institutes',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              icon: const Icon(CupertinoIcons.search, color: Colors.black),
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Add any filters or categories here if needed
            Expanded(
              child: _buildInstituteList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInstituteList() {
    return ListView(
      children: const [
        InstituteCard(
          name: 'Institute 1',
          imageUrl: 'assets/InstituteImage.jpg',
          location: 'Location 1',
          rating: 4.5,
          numberOfRatings: 120,
          description: 'Description of Institute 1',
        ),
        InstituteCard(
          name: 'Institute 2',
          imageUrl: 'assets/InstituteImage.jpg',
          location: 'Location 2',
          rating: 4.0,
          numberOfRatings: 98,
          description: 'Description of Institute 2',
        ),
        InstituteCard(
          name: 'Institute 3',
          imageUrl: 'assets/InstituteImage.jpg',
          location: 'Location 3',
          rating: 4.8,
          numberOfRatings: 150,
          description: 'Description of Institute 3',
        ),
        InstituteCard(
          name: 'Institute 4',
          imageUrl: 'assets/InstituteImage.jpg',
          location: 'Location 4',
          rating: 3.9,
          numberOfRatings: 75,
          description: 'Description of Institute 4',
        ),
        InstituteCard(
          name: 'Institute 5',
          imageUrl: 'assets/InstituteImage.jpg',
          location: 'Location 5',
          rating: 4.2,
          numberOfRatings: 110,
          description: 'Description of Institute 5',
        ),
      ],
    );
  }
}


