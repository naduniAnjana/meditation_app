import 'package:flutter/material.dart';
import 'package:silentmoon/app/configs/theme.dart';
import 'package:silentmoon/pages/login_page.dart';
import 'package:silentmoon/pages/signup_page.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({super.key});

  @override
  State<IntroductionPage> createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [

            const SizedBox(height: 80),

            // app name
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Silent',
                  style: TextStyle(
                    color: ThemeConfigs.color4,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),

                const SizedBox(width: 8),

                Image.asset('assets/moon.png', width: 30, height: 30),

                const SizedBox(width: 8),

                const Text(
                  'Moon',
                  style: TextStyle(
                    color: ThemeConfigs.color4,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),

            // image
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Image.asset(
                'assets/listening.png',
              ),
            ),

            const SizedBox(height: 50),

            // what we do
            const Text(
              'What we do',
              style: TextStyle(
                color: ThemeConfigs.color5,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // description
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Text(
                'Thousand of people are using slient moon for smalls meditation',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ThemeConfigs.color6,
                ),
              ),
            ),

            const SizedBox(height: 15),

            // button
            Padding(
              padding: const EdgeInsets.only(top: 70),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const SignupPage()));
                },
                child: Container(
                  height: 60,
                  width: 350,
                  decoration: BoxDecoration(
                    color: ThemeConfigs.color3,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Center(
                    child: Text(
                      'SIGN UP',
                      style: TextStyle(
                        color: ThemeConfigs.color2,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // login link
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'ALREADY HAVE AN ACCOUNT?',
                  style: TextStyle(
                    color: ThemeConfigs.color6,
                  ),
                ),
            
                const SizedBox(width: 5),
            
                GestureDetector (
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const LoginPage()));
                  },
                  child: const Text(
                    'LOG IN',
                    style: TextStyle(
                      color: ThemeConfigs.color3
                    ),
                  ),
                ),
              ],
            )
          ],   
        ),
      ),
    );
  }
}