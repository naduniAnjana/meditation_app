import 'package:flutter/material.dart';
import 'package:silentmoon/app/configs/theme.dart';
import 'package:silentmoon/pages/introduction_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeConfigs.color1,
      body: Stack(
        children: [
          Opacity(
            opacity: 0.4,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/background.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          Center(
            child: Column(
              children: [
                // welcome message
                const Padding(
                  padding: EdgeInsets.only(top: 100),
                  child: Text(
                    'Welcome to Sleep',
                    style: TextStyle(
                      fontSize: 36,
                      color: ThemeConfigs.color2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // description
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    'Explore the new king of sleep. It uses sound and vesualization to create perfect conditions for refreshing sleep.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: ThemeConfigs.color2, fontSize: 16),
                  ),
                ),

                // image
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 80, bottom: 60),
                  child: Image.asset('assets/birds.png'),
                ),

                // button
                Padding(
                  padding: const EdgeInsets.only(top: 70),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const IntroductionPage(),
                        ),
                      );
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
                          'GET STARTED',
                          style: TextStyle(color: ThemeConfigs.color2),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
