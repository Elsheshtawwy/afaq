import 'package:flutter/material.dart';

class LanguageSelectionScreen extends StatefulWidget {
  @override
  _LanguageSelectionScreenState createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String selectedLanguage = 'English (US)';

  final List<String> subCategories = ['English (US)', 'English (UK)'];
  final List<String> allLanguages = [
    'English (US)',
    'Arabic',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Language', style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Container(
        color: Color(0xFFF6F8FB),
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'SubCategories:',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8),
            ...subCategories.map((language) => LanguageOption(
                  language: language,
                  isSelected: selectedLanguage == language,
                  onTap: () {
                    setState(() {
                      selectedLanguage = language;
                    });
                  },
                )),
            SizedBox(height: 24),
            Text(
              'All Language',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8),
            ...allLanguages.map((language) => LanguageOption(
                  language: language,
                  isSelected: selectedLanguage == language,
                  onTap: () {
                    setState(() {
                      selectedLanguage = language;
                    });
                  },
                )),
          ],
        ),
      ),
    );
  }
}

class LanguageOption extends StatelessWidget {
  final String language;
  final bool isSelected;
  final VoidCallback onTap;

  LanguageOption({
    required this.language,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                language,
                style: TextStyle(fontSize: 14.0),
              ),
            ),
            Checkbox(
              value: isSelected,
              onChanged: (_) => onTap(),
              activeColor:
                  Color(0xFF008B7D), // Green color for selected checkbox
              checkColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
