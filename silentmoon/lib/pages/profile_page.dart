import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:silentmoon/app/configs/theme.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeConfigs.color26,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Topic
            Padding(
              padding: EdgeInsets.only(top: 50),
              child: Text(
                "Profile",
                style: TextStyle(
                  color: ThemeConfigs.color19,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
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
                      onPressed: () {
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
        
            // Name
            Center(
              child: Text(
                "Nanduni Anjana",
                style: TextStyle(
                  color: ThemeConfigs.color14,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 35),
        
            // Container1
            Container(
              height: 160,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(15),
              ),

              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          Icon(
                            PhosphorIconsBold.user,
                            size: 18,
                            color: ThemeConfigs.color4,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Account Info',
                            style: TextStyle(
                              color: ThemeConfigs.color4,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 200),
                      
                          Expanded(
                            child: Icon(
                              PhosphorIconsBold.caretRight,
                              size: 18,
                              color: ThemeConfigs.color21,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(height: 1, color: ThemeConfigs.color28),
                    const SizedBox(height: 15),
                    InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          Icon(
                            PhosphorIconsBold.key,
                            size: 18,
                            color: ThemeConfigs.color4,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Change Password',
                            style: TextStyle(
                              color: ThemeConfigs.color4,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 165),
                      
                          Expanded(
                            child: Icon(
                              PhosphorIconsBold.caretRight,
                              size: 18,
                              color: ThemeConfigs.color21,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(height: 1, color: ThemeConfigs.color28),
                    const SizedBox(height: 15),
                    InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          Icon(
                            PhosphorIconsBold.heartStraight,
                            size: 18,
                            color: ThemeConfigs.color4,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'My Favourite',
                            style: TextStyle(
                              color: ThemeConfigs.color4,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 200),
                      
                          Expanded(
                            child: Icon(
                              PhosphorIconsBold.caretRight,
                              size: 18,
                              color: ThemeConfigs.color21,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Container2
            Container(
              height: 110,
              width: double.infinity,
              decoration: BoxDecoration(
                color: ThemeConfigs.color2,
                borderRadius: BorderRadius.circular(15),
              ),

              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          Icon(
                            PhosphorIconsBold.bell,
                            size: 18,
                            color: ThemeConfigs.color4,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Meditation Reminders',
                            style: TextStyle(
                              color: ThemeConfigs.color4,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 135),
                      
                          Expanded(
                            child: Icon(
                              PhosphorIconsBold.caretRight,
                              size: 18,
                              color: ThemeConfigs.color21,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(height: 1, color: ThemeConfigs.color28),
                    const SizedBox(height: 15),
                    InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          Icon(
                            PhosphorIconsBold.alarm,
                            size: 18,
                            color: ThemeConfigs.color4,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Bedtime Reminders',
                            style: TextStyle(
                              color: ThemeConfigs.color4,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 153),
                      
                          Expanded(
                            child: Icon(
                              PhosphorIconsBold.caretRight,
                              size: 18,
                              color: ThemeConfigs.color21,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Conatiner3
            Container(
              height: 160,
              width: double.infinity,
              decoration: BoxDecoration(
                color: ThemeConfigs.color2,
                borderRadius: BorderRadius.circular(15),
              ),

              child: Padding(
                padding: const EdgeInsets.only(top: 6, left: 15),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          Icon(
                            PhosphorIconsBold.moonStars,
                            size: 18,
                            color: ThemeConfigs.color4,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Dark Mode',
                            style: TextStyle(
                              color: ThemeConfigs.color4,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 190),

                          Transform.scale(
                            scale: 0.55,
                            child: Switch(
                              value: isDarkMode,
                              activeThumbColor: ThemeConfigs.color27,
                              onChanged: (value) {
                                setState(() {
                                  isDarkMode = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    // const SizedBox(height: ),
                    Container(height: 1, color: ThemeConfigs.color28),
                    const SizedBox(height: 15),
                    InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          Icon(
                            PhosphorIconsBold.gear,
                            size: 18,
                            color: ThemeConfigs.color4,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Settings',
                            style: TextStyle(
                              color: ThemeConfigs.color4,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 219),
                      
                          Expanded(
                            child: Icon(
                              PhosphorIconsBold.caretRight,
                              size: 18,
                              color: ThemeConfigs.color21,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(height: 1, color: ThemeConfigs.color28),
                    const SizedBox(height: 15),
                    InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          Icon(
                            PhosphorIconsBold.signOut,
                            size: 18,
                            color: ThemeConfigs.color4,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Logout',
                            style: TextStyle(
                              color: ThemeConfigs.color4,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 230),
                      
                          Expanded(
                            child: Icon(
                              PhosphorIconsBold.caretRight,
                              size: 18,
                              color: ThemeConfigs.color21,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}