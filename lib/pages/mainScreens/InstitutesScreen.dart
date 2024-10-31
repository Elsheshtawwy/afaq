import 'package:afaq/models/InstituteModel.dart';
import 'package:afaq/widgets/SearchBar.dart';
import 'package:afaq/widgets/cards/instituteCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class InstitutesScreen extends StatefulWidget {
  final List<InstituteModel> institutes;

  const InstitutesScreen({super.key, required this.institutes});

  @override
  _InstitutesScreenState createState() => _InstitutesScreenState();
}

class _InstitutesScreenState extends State<InstitutesScreen> {
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        searchQuery = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<InstituteModel> filteredItems = widget.institutes
        .where((item) =>
            item.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
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
              onPressed: () {
                const CustomSearchBar()
                    .showSearchDialog(context, _searchController, 'Institute');
              },
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildInstituteList(filteredItems),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInstituteList(List<InstituteModel> filteredItems) {
    return ListView.builder(
      itemCount: filteredItems.length,
      itemBuilder: (context, index) {
        return InstituteCard(
          institute: filteredItems[index],
        );
      },
    );
  }
}
