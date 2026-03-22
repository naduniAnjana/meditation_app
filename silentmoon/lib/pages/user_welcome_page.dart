import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:silentmoon/app/configs/theme.dart';
import 'package:silentmoon/components/bottom_navbar.dart';

class UserWelcomePage extends StatefulWidget {
  const UserWelcomePage({super.key});

  @override
  State<UserWelcomePage> createState() => _UserWelcomePageState();
}

class _UserWelcomePageState extends State<UserWelcomePage> {
  String userName = '';

  String _capitalize(String s) => s.isNotEmpty ? '${s[0].toUpperCase()}${s.substring(1)}' : s;

  @override
  void initState() {
    super.initState();
    fetchUserName();
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
      backgroundColor: ThemeConfigs.color3,
      body: Center(
        child: Column(
          children: [
            // app name
            Padding(
              padding: const EdgeInsets.only(top: 70),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Silent',
                    style: TextStyle(
                      color: ThemeConfigs.color2,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                  
                  const SizedBox(width: 8),
                  
                  Image.asset('assets/images/app/moon.png', width: 30, height: 30),
                  
                  const SizedBox(width: 8),
                  
                  const Text(
                    'Moon',
                    style: TextStyle(
                      color: ThemeConfigs.color2,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),
        
            // hi message
            Text(
              'Hi ${userName.isNotEmpty ? _capitalize(userName) : "User"}, Welcome',
              style: const TextStyle(
                color: ThemeConfigs.color2,
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
        
            // to silent moon text
            const Text(
              'to Silent Moon',
              style: TextStyle(
                color: ThemeConfigs.color2,
                fontSize: 28,
              ),
            ),

            const SizedBox(height: 20), 
        
            // description
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'Explore the app, Find some peace of mind to prepare for meditation.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ThemeConfigs.color2,
                ),
              ),
            ),
        
            // image
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 70),
              child: Image.asset('assets/images/app/medi.png', width: 350, height: 350),
            ),
        
            // button
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const BottomNavbar()));
              },
              child: Container(
                height: 60,
                width: 350,
                decoration: BoxDecoration(
                  color: ThemeConfigs.color2,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Center(
                  child: Text(
                    'GET STARTED',
                    style: TextStyle(
                      color: ThemeConfigs.color11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}