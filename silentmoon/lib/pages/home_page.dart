import 'package:flutter/material.dart';
import 'package:silentmoon/app/configs/theme.dart';
import 'package:silentmoon/pages/recomended_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // app name
          Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Row(
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
          ),

          const SizedBox(height: 30),

          // good morning message with the name
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Good Morning, Nanduni',
              style: TextStyle(
                color: ThemeConfigs.color14,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 5),

          // wish
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'We Wish you have a good day',
              style: TextStyle(color: ThemeConfigs.color6, fontSize: 17),
            ),
          ),

          const SizedBox(height: 30),

          // basics and relaxation containers
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 177,
                  height: 200,
                  decoration: const BoxDecoration(
                    color: ThemeConfigs.color3,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5, left: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // image
                        Padding(
                          padding: const EdgeInsets.only(left: 55),
                          child: Image.asset(
                            'assets/basic.png',
                            width: 90,
                            height: 90,
                          ),
                        ),
                        //topic
                        const Text(
                          "Basics",
                          style: TextStyle(
                            color: ThemeConfigs.color2,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),

                        // course text
                        const Text(
                          "COURSE",
                          style: TextStyle(color: ThemeConfigs.color15),
                        ),

                        const SizedBox(height: 16),

                        // time
                        Row(
                          children: [
                            const Text(
                              "3-10 MIN",
                              style: TextStyle(color: ThemeConfigs.color15),
                            ),

                            const SizedBox(width: 20),

                            //start buuton
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: 30,
                                width: 60,
                                decoration: BoxDecoration(
                                  color: ThemeConfigs.color2,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: const Center(
                                  child: Text(
                                    "START",
                                    style: TextStyle(
                                      color: ThemeConfigs.color14,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 177,
                  height: 200,
                  decoration: const BoxDecoration(
                    color: ThemeConfigs.color16,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5, left: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // image
                        Padding(
                          padding: const EdgeInsets.only(left: 55),
                          child: Image.asset(
                            'assets/music.png',
                            width: 85,
                            height: 85,
                          ),
                        ),

                        const SizedBox(height: 5),

                        //topic
                        const Text(
                          "Relaxation",
                          style: TextStyle(
                            color: ThemeConfigs.color2,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),

                        // course text
                        const Text(
                          "MUSIC",
                          style: TextStyle(color: ThemeConfigs.color15),
                        ),

                        const SizedBox(height: 16),

                        // time
                        Row(
                          children: [
                            const Text(
                              "3-10 MIN",
                              style: TextStyle(color: ThemeConfigs.color15),
                            ),

                            const SizedBox(width: 20),

                            //start buuton
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: 30,
                                width: 60,
                                decoration: BoxDecoration(
                                  color: ThemeConfigs.color2,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: const Center(
                                  child: Text(
                                    "START",
                                    style: TextStyle(
                                      color: ThemeConfigs.color14,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 15),

          // daily thought container
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              width: 400,
              height: 120,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/background1.jpg'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 27,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // topic
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Daily Thought',
                          style: TextStyle(
                            color: ThemeConfigs.color2,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),

                        SizedBox(height: 10),

                        // description
                        Text(
                          'MEDITATION * 3-10 MIN',
                          style: TextStyle(
                            color: ThemeConfigs.color17,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(width: 30),

                    // button
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: ThemeConfigs.color2,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.play_arrow,
                            color: ThemeConfigs.color14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 35),

          // recommended text
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 22),
            child: Text(
              'Recommended for you',
              style: TextStyle(
                color: ThemeConfigs.color18,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 10),

          // recomnded for you
          const RecomendedPage(),
        ],
      ),
    );
  }
}
