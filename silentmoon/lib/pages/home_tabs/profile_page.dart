import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:silentmoon/app/configs/theme.dart';
import 'package:silentmoon/pages/profile_tabs/bedtime_reminder_page.dart';
import 'package:silentmoon/pages/profile_tabs/meditation_reminder_page.dart';
import 'package:silentmoon/pages/profile_tabs/my_favourite_page.dart';
import 'package:silentmoon/pages/welcome_page.dart';
import 'package:silentmoon/app/configs/theme_notifier.dart';
import 'package:silentmoon/pages/profile_tabs/account_info_page.dart';
import 'package:silentmoon/pages/profile_tabs/change_password_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isDarkMode = false;
  String userName = '';

  String _capitalize(String s) => s.isNotEmpty ? '${s[0].toUpperCase()}${s.substring(1)}' : s;

  @override
  void initState() {
    super.initState();
    fetchUserName();
  }

  Future<void> _logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      
      try {
        final GoogleSignIn googleSignIn = GoogleSignIn();
        if (await googleSignIn.isSignedIn()) {
          await googleSignIn.signOut();
        }
      } catch (e) {
        // Ignore Google Sign Out error
      }

      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const WelcomePage()),
          (route) => false,
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error logging out: $e')),
        );
      }
    }
  }

  Future<void> fetchUserName() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .get();

        if (userDoc.exists && userDoc.data() != null) {
          var data = userDoc.data() as Map<String, dynamic>;
          setState(() {
            userName = data['username'] ?? currentUser.displayName ?? '';
          });
        } else {
          setState(() {
            userName = currentUser.displayName ?? '';
          });
        }
      } catch (e) {
        setState(() {
          userName = currentUser.displayName ?? '';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeConfigs.color26,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Topic
              const SizedBox(height: 20),
              Text(
                "Profile",
                style: TextStyle(
                  color: ThemeConfigs.color19,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // Profile photo
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    const CircleAvatar(
                      radius: 60,
                      backgroundColor: ThemeConfigs.color29,
                      child: Icon(
                        Icons.person,
                        size: 60,
                        color: ThemeConfigs.color2,
                      ),
                    ),
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: ThemeConfigs.color27,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(
                          Icons.camera_alt,
                          size: 18,
                          color: ThemeConfigs.color2,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),

              // Name
              Center(
                child: Text(
                  userName.isNotEmpty ? _capitalize(userName) : "User",
                  style: const TextStyle(
                    color: ThemeConfigs.color14,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Container1
              _buildOptionContainer(
                color: Colors.white,
                items: [
                  _OptionItem(
                    icon: PhosphorIconsBold.user, 
                    title: 'Account Info',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AccountInfoPage(),
                        ),
                      ).then((_) => fetchUserName());
                    },
                  ),
                  _OptionItem(
                    icon: PhosphorIconsBold.key, 
                    title: 'Change Password',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ChangePasswordPage(),
                        ),
                      );
                    },
                  ),
                  _OptionItem(
                    icon: PhosphorIconsBold.heartStraight,
                    title: 'My Favourite',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const MyFavouritePage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Container2
              _buildOptionContainer(
                color: ThemeConfigs.color2,
                items: [
                  _OptionItem(
                    icon: PhosphorIconsBold.bell,
                    title: 'Meditation Reminders',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const MeditationReminderPage(),
                        ),
                      );
                    },
                  ),
                  _OptionItem(
                    icon: PhosphorIconsBold.alarm,
                    title: 'Bedtime Reminders',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const BedtimeReminderPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Container3
              _buildOptionContainer(
                color: ThemeConfigs.color2,
                items: [
                  _OptionItem(
                    icon: PhosphorIconsBold.moonStars,
                    title: 'Dark Mode',
                    trailing: Transform.scale(
                      scale: 0.55,
                      child: Switch(
                        value: isDarkMode,
                        activeThumbColor: ThemeConfigs.color27,
                        onChanged: (value) {
                          setState(() {
                            isDarkMode = value;
                            ThemeNotifier.themeMode.value = value ? ThemeMode.dark : ThemeMode.light;
                          });
                        },
                      ),
                    ),
                  ),
                  _OptionItem(icon: PhosphorIconsBold.gear, title: 'Settings'),
                  _OptionItem(
                    icon: PhosphorIconsBold.signOut,
                    title: 'Logout',
                    onTap: () => _logout(context),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Generic container builder
  Widget _buildOptionContainer({
    required Color color,
    required List<_OptionItem> items,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: items.map((item) {
          int index = items.indexOf(item);
          return Column(
            children: [
              InkWell(
                onTap: item.onTap,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Row(
                    children: [
                      Icon(item.icon, size: 18, color: ThemeConfigs.color4),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          item.title,
                          style: TextStyle(
                            color: ThemeConfigs.color4,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      if (item.trailing != null)
                        item.trailing!
                      else
                        Icon(
                          PhosphorIconsBold.caretRight,
                          size: 18,
                          color: ThemeConfigs.color21,
                        ),
                    ],
                  ),
                ),
              ),
              if (index != items.length - 1)
                Container(height: 1, color: ThemeConfigs.color28),
            ],
          );
        }).toList(),
      ),
    );
  }
}

// Helper class for container items
class _OptionItem {
  final IconData icon;
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;

  _OptionItem({required this.icon, required this.title, this.trailing, this.onTap});
}