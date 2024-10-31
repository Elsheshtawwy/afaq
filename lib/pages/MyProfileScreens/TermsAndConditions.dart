import 'package:afaq/helpers/functions.dart';
import 'package:afaq/providers/dark_mode_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = getSize(context).width;
    final screenHeight = getSize(context).height;
    final padding = screenWidth * 0.04;
    final titleFontSize = screenWidth * 0.06;
    final contentFontSize = screenWidth * 0.04;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Terms & Conditions',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(padding),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SectionTitle(title: 'AFAQ App', fontSize: titleFontSize),
                  ],
                ),
                Row(
                  children: [
                    SectionTitle(
                        title: 'Terms and Conditions', fontSize: titleFontSize),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
                SectionContent(
                  content: '1. Acceptance of Terms\n\n'
                      'By downloading, installing, or using the AFAQ app, you agree to comply with and be bound by these Terms and Conditions. If you do not agree to these terms, please do not use the app.\n\n',
                  fontSize: contentFontSize,
                ),
                SectionContent(
                  content: '2. Purpose of the App\n\n'
                      'AFAQ is an educational platform designed to connect users with academic and vocational courses from various institutes. Through the app, users can browse courses, read reviews, view enrollment details, and register for courses.\n\n',
                  fontSize: contentFontSize,
                ),
                SectionContent(
                  content: '3. User Registration\n\n'
                      'To use certain features of AFAQ, you may need to create an account. You agree to:\n'
                      '- Provide accurate and up-to-date information during registration.\n'
                      '- Maintain the security of your account by not sharing your password with others.\n'
                      '- Accept responsibility for any activity under your account.\n\n',
                  fontSize: contentFontSize,
                ),
                SectionContent(
                  content: '4. Course Information and Availability\n\n'
                      'The AFAQ app provides information about courses, including start and end dates, enrollment limits, and other details. However, AFAQ does not guarantee:\n'
                      '- The accuracy, reliability, or completeness of course descriptions, availability, or any other information.\n'
                      '- That a course listed in the app will not be canceled or modified by the institute.\n\n',
                  fontSize: contentFontSize,
                ),
                SectionContent(
                  content: '5. Registration and Payments\n\n'
                      'When you register for a course through AFAQ:\n'
                      '- Any payments made are processed by the respective institute, not by AFAQ. AFAQ does not handle refunds or disputes related to course payments.\n'
                      '- Your registration may be subject to the institute\'s cancellation or refund policy.\n\n',
                  fontSize: contentFontSize,
                ),
                SectionContent(
                  content: '6. Loyalty and Discounts\n\n'
                      'As part of AFAQ’s loyalty program, users who register for courses through the app may receive discounts or promotional offers for future courses. AFAQ reserves the right to modify or discontinue the loyalty program at any time without notice.\n\n',
                  fontSize: contentFontSize,
                ),
                SectionContent(
                  content: '7. Ratings and Reviews\n\n'
                      'AFAQ allows users to rate and review courses, institutes, and instructors. When posting a review, you agree to:\n'
                      '- Provide honest, accurate, and respectful feedback.\n'
                      '- Avoid posting defamatory, offensive, or misleading content.\n\n'
                      'AFAQ reserves the right to remove any review that violates these terms.\n\n',
                  fontSize: contentFontSize,
                ),
                SectionContent(
                  content: '8. Wishlist and Notifications\n\n'
                      'AFAQ provides a wishlist feature and notifications for courses. While we aim to notify you about course availability as accurately as possible, AFAQ is not responsible for any missed notifications or delays in updating course status.\n\n',
                  fontSize: contentFontSize,
                ),
                SectionContent(
                  content: '9. Intellectual Property\n\n'
                      'All content, trademarks, logos, and other intellectual property in the app are the property of AFAQ or its licensors. You may not copy, reproduce, or distribute any part of the app without written permission from AFAQ.\n\n',
                  fontSize: contentFontSize,
                ),
                SectionContent(
                  content: '10. Limitation of Liability\n\n'
                      'AFAQ is not responsible for any loss, injury, or damages arising from:\n'
                      '- Inaccuracies in course information, reviews, or instructor ratings.\n'
                      '- Actions taken by institutes, such as course cancellations or modifications.\n'
                      '- Any technical issues, interruptions, or app malfunctions.\n\n',
                  fontSize: contentFontSize,
                ),
                SectionContent(
                  content: '11. Changes to Terms\n\n'
                      'AFAQ reserves the right to modify these Terms and Conditions at any time. Changes will be effective upon posting within the app. Your continued use of AFAQ after changes are posted constitutes your acceptance of the revised terms.\n\n',
                  fontSize: contentFontSize,
                ),
                SectionContent(
                  content: '12. Contact Us\n\n'
                      'If you have any questions or concerns about these Terms and Conditions, please contact us through the app’s support section.\n\n',
                  fontSize: contentFontSize,
                ),
                SizedBox(height: screenHeight * 0.03),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  final double fontSize;

  const SectionTitle({super.key, required this.title, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: Colors.blueAccent,
      ),
    );
  }
}

class SectionContent extends StatelessWidget {
  final String content;
  final double fontSize;

  const SectionContent(
      {super.key, required this.content, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Consumer<DarkModeProvider>(
        builder: (context, darkModeProvider, child) {
      return Text(
        content,
        style: TextStyle(
          fontSize: fontSize,
          height: 1.5,
          color: darkModeProvider.isDark ? Colors.white70 : Colors.black87,
        ),
      );
    });
  }
}
