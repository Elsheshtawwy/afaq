import 'package:afaq/helpers/functions.dart';
import 'package:afaq/providers/dark_mode_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class InviteFriendsScreen extends StatelessWidget {
  final String appLink =
      'https://www.mediafire.com/file/mwdgfdbcrv9kvpc/app-release.apk/file';

  const InviteFriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DarkModeProvider>(
        builder: (context, darkModeProvider, child) {
      return Scaffold(
        backgroundColor: darkModeProvider.isDark ? null : Colors.white,
        appBar: AppBar(
          title: const Text(
            "Invite Friends",
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Share with your friends",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  child: Image.asset(
                    'assets/share.gif',
                    width: getSize(context).width * 0.4,
                    height: getSize(context).width * 0.4,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    Share.share('قم بتنزيل تطبيق أفاق من هنا: $appLink');
                  },
                  icon: Icon(Icons.share,
                      color:
                          darkModeProvider.isDark ? Colors.teal : Colors.white),
                  label: Text(
                    "Share Now",
                    style: TextStyle(
                        color: darkModeProvider.isDark
                            ? Colors.teal
                            : Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        darkModeProvider.isDark ? Colors.white : Colors.teal,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
