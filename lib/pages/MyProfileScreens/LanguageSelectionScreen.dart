import 'package:flutter/material.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

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
        elevation: 0,
        title: const Text('Language',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'SubCategories:',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            ...subCategories.map((language) => LanguageOption(
                  language: language,
                  isSelected: selectedLanguage == language,
                  onTap: () {
                    setState(() {
                      selectedLanguage = language;
                    });
                  },
                )),
            const SizedBox(height: 24),
            const Text(
              'All Language',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
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

  const LanguageOption({
    super.key,
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
                style: const TextStyle(fontSize: 14.0),
              ),
            ),
            Checkbox(
              value: isSelected,
              onChanged: (_) => onTap(),
              activeColor: const Color(0xFF008B7D),
              checkColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
