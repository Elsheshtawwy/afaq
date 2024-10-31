import 'package:afaq/providers/dark_mode_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Help Center',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome to the Help Center!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Here are some frequently asked questions:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  _buildFAQItem(
                      context, "How do I reset my password?", "resetPassword"),
                  _buildFAQItem(
                      context, "How do I contact support?", "contactSupport"),
                  _buildFAQItem(
                      context, "Where can I find the user guide?", "userGuide"),
                  _buildFAQItem(context,
                      "What should I do if I encounter a bug?", "reportBug"),
                  _buildFAQItem(
                      context,
                      "How do I update my profile information?",
                      "updateProfile"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQItem(BuildContext context, String question, String route) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    FAQScreen(title: question, contentKey: route)),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              const Icon(Icons.help_outline, color: Colors.blue),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  question,
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ),
              const Icon(Icons.arrow_forward_ios, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}

class FAQScreen extends StatelessWidget {
  final String title;
  final String contentKey;

  const FAQScreen({super.key, required this.title, required this.contentKey});

  @override
  Widget build(BuildContext context) {
    final contentData = _getContent(contentKey);

    return Consumer<DarkModeProvider>(
        builder: (context, darkModeProvider, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            title,
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                Image.asset(contentData['image']!,
                    width: 200,
                    color: darkModeProvider.isDark ? Colors.white : null),
                const SizedBox(height: 30),
                Text(
                  contentData['content']!,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Map<String, String> _getContent(String key) {
    switch (key) {
      case "resetPassword":
        return {
          'content':
              "To reset your password, go to the login page and click on 'Forgot Password?'. We will send a reset message to your email. Open the email and click on the link to reset your password directly.",
          'image': 'assets/HelpCenter/resetPassword.png'
        };
      case "contactSupport":
        return {
          'content':
              "You can contact support by emailing AfaqSupport@gmail.com or calling our hotline at (123) 456-7890.",
          'image': 'assets/HelpCenter/contactSupport.png'
        };
      case "userGuide":
        return {
          'content':
              "The user guide can be found in the 'Help' section of the app or downloaded from our website.",
          'image': 'assets/HelpCenter/userGuide.png'
        };
      case "reportBug":
        return {
          'content':
              "If you encounter a bug, please report it through the feedback form in the app or email us at AfaqBugs@gmail.com.",
          'image': 'assets/HelpCenter/reportBug.png'
        };
      case "updateProfile":
        return {
          'content':
              "To update your profile information, go to 'Settings' and select 'Edit Profile'. Make your changes and click on update.",
          'image': 'assets/HelpCenter/updateProfile.png'
        };
      default:
        return {
          'content': "Content not available.",
          'image': 'assets/HelpCenter/default.png'
        };
    }
  }
}
