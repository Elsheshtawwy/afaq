import 'package:afaq/providers/base_provider.dart';
import 'package:afaq/providers/dark_mode_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:provider/provider.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'My Profile',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: currentUser == null
          ? const Center(child: Text('No user is currently signed in.'))
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const ProfilePicture(),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView(
                      children: [
                        ProfileOption(
                          icon: Icons.person,
                          text: "Edit Profile",
                          onTap: () {
                            Navigator.pushNamed(context, '/editProfile');
                          },
                        ),
                        const ProfileOption(
                            icon: Icons.payment, text: "Payment Option"),
                        ProfileOption(
                          icon: Icons.notifications,
                          text: "Notifications",
                          onTap: () {
                            Navigator.pushNamed(context, '/notifications');
                          },
                        ),
                        const ProfileOption(
                            icon: Icons.security, text: "Security"),
                        ProfileOption(
                          icon: Icons.language,
                          text: "Language",
                          trailing: const Text(
                            "English (US)",
                            style: TextStyle(color: Colors.blue),
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, '/LanguageSelection');
                          },
                        ),
                        ProfileOption(
                          icon: Icons.dark_mode,
                          text: "Dark Mode",
                          trailing: Consumer<DarkModeProvider>(
                            builder: (context, darkModeProvider, child) {
                              return Switch(
                                activeColor: Colors.teal,
                                inactiveThumbColor: Colors.grey,
                                value: darkModeProvider.isDark,
                                onChanged: (bool value) {
                                  darkModeProvider.SwitchMode();
                                },
                              );
                            },
                          ),
                        ),
                        ProfileOption(
                          icon: Icons.description,
                          text: "Terms & Conditions",
                          onTap: () {
                            Navigator.pushNamed(context, '/termsAndConditions');
                          },
                        ),
                        ProfileOption(
                            icon: Icons.help,
                            text: "Help Center",
                            onTap: () {
                              Navigator.pushNamed(context, '/helpCenter');
                            }),
                        ProfileOption(
                          icon: Icons.person_add,
                          text: "Invite Friends",
                          onTap: () {
                            Navigator.pushNamed(
                                context, '/inviteFriendsScreen');
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 4,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'My Courses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Inbox',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'Transaction',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class ProfileOption extends StatelessWidget {
  final IconData? icon;
  final String text;
  final Widget? trailing;
  final VoidCallback? onTap;

  const ProfileOption({
    super.key,
    this.icon,
    required this.text,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon != null ? Icon(icon) : null,
      title: Text(text, style: const TextStyle(fontSize: 16)),
      trailing: trailing ?? const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}

class ProfilePicture extends StatefulWidget {
  final double radius;
  final double size;

  const ProfilePicture({super.key, this.radius = 50, this.size = 100});

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    return FutureBuilder<String?>(
      future: currentUser != null
          ? getProfilePicture(currentUser.uid)
          : Future.value(
              "https://static.vecteezy.com/system/resources/thumbnails/002/318/271/small_2x/user-profile-icon-free-vector.jpg"),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.hasError ||
            !snapshot.hasData ||
            snapshot.data == null) {
          return _buildProfilePicture(
            const AssetImage('assets/profile.png'),
          );
        } else {
          return _buildProfilePicture(
            NetworkImage(snapshot.data!),
          );
        }
      },
    );
  }

  Widget _buildProfilePicture(ImageProvider imageProvider) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: const Color(0xff167F71),
          width: 2,
        ),
      ),
      width: widget.size,
      child: CircleAvatar(
        radius: widget.radius,
        backgroundImage: imageProvider,
        backgroundColor: Colors.grey[200],
      ),
    );
  }

  Future<String?> getProfilePicture(String userId) async {
    try {
      BaseProvider().setBusy(true);
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      BaseProvider().setBusy(false);
      return userDoc.get('profilePicture') as String?;
    } catch (e) {
      print('Error fetching profile picture: $e');
      return null;
    }
  }
}
