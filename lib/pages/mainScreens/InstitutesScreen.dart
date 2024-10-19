import 'package:afaq/models/InstituteModel.dart';
import 'package:afaq/widgets/cards/instituteCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class InstitutesScreen extends StatelessWidget {
    final List<InstituteModel> Institutes;

  const InstitutesScreen({super.key, required this.Institutes});

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
    
    return ListView.builder(
      itemCount: Institutes.length,
      itemBuilder: (context, index) {
        return InstituteCard(
          institute: Institutes[index],
        );
      },
    );
  }
}


