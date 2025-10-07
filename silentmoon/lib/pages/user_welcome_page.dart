import 'package:flutter/material.dart';
import 'package:silentmoon/app/configs/theme.dart';
import 'package:silentmoon/components/bottom_navbar.dart';

class UserWelcomePage extends StatefulWidget {
  const UserWelcomePage({super.key});

  @override
  State<UserWelcomePage> createState() => _UserWelcomePageState();
}

class _UserWelcomePageState extends State<UserWelcomePage> {
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
                  
                  Image.asset('assets/moon.png', width: 30, height: 30),
                  
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
            const Text(
              'Hi Nanduni, Welcome',
              style: TextStyle(
                color: ThemeConfigs.color2,
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),

            // const SizedBox(height: 10),
        
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
              child: Image.asset('assets/medi.png', width: 300, height: 300),
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