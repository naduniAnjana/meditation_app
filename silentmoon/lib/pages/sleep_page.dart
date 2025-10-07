import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:silentmoon/app/configs/theme.dart';

class SleepPage extends StatefulWidget {
  const SleepPage({super.key});

  @override
  State<SleepPage> createState() => _SleepPageState();
}

class _SleepPageState extends State<SleepPage> {
  // Define a list of different icons with their labels
  final List<Map<String, dynamic>> menuItems = [
    {"icon": Icons.wind_power, "label": "All"},
    {"icon": Icons.favorite, "label": "My"},
    {"icon": Icons.face, "label": "Anxious"},
    {"icon": Icons.nightlight_round, "label": "Sleep"},
    {"icon": Icons.child_care, "label": "Kids"},
    {"icon": Icons.music_note, "label": "Music"},
    {"icon": Icons.favorite, "label": "Love"},
  ];

  int selectedIndex = 0;

  final List<Map<String, String>> containerData = [
    {"image": 'assets/sleep1.png'},
    {"image": 'assets/sleep2.png'},
    {"image": 'assets/sleep3.jpg'},
    {"image": 'assets/sleep4.png'},
    {"image": 'assets/sleep5.jpg'},
    {"image": 'assets/sleep6.jpg'},
    {"image": 'assets/sleep7.png'},
    {"image": 'assets/sleep8.png'},
  ];

  final List<Map<String, String>> containerText = [
    {"text": "NIght Island"},
    {"text": "Sweet Sleep"},
    {"text": "Calm Your Mind"},
    {"text": "Sleep Better"},
    {"text": "Daily Gratitude"},
    {"text": "Stress Relief"},
    {"text": "Stress Relief"},
    {"text": "Stress Relief"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF001C54),
      body: Stack(
        children: [
          Opacity(
            opacity: 0.2,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/night.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          Column(
            children: [
              // Topic
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Text(
                    "Sleep Stories",
                    style: TextStyle(
                      color: ThemeConfigs.color2,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // Description
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: const Text(
                  "Soothing bedtime stories to help you fall into a deep and natural sleep",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: ThemeConfigs.color2),
                ),
              ),

              const SizedBox(height: 18),

              // Menu Bar
              SizedBox(
                height: 100,
                width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: menuItems.length,
                  itemBuilder: (context, index) {
                    bool isSelected = selectedIndex == index;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Column(
                          children: [
                            // Icon Container
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              width: 55,
                              height: 55,
                              decoration: BoxDecoration(
                                color:
                                    isSelected
                                        ? ThemeConfigs.color3
                                        : ThemeConfigs.color25,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Icon(
                                    menuItems[index]["icon"],
                                    color: ThemeConfigs.color2,
                                  ),
                                ),
                              ),
                            ),

                            // Text Label
                            Text(
                              menuItems[index]["label"],
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color:
                                    isSelected
                                        ? ThemeConfigs.color3
                                        : ThemeConfigs.color21,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Ocean Moon Container
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Opacity(
                  opacity: 0.8,
                  child: Container(
                    width: double.infinity,
                    height: 220,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/background4.jpg'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 30,
                        right: 30,
                        top: 70,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'The Ocean Moon',
                            style: TextStyle(
                              color: const Color.fromARGB(255, 255, 251, 45),
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                  
                          SizedBox(height: 10),
                  
                          // Description
                          Text(
                            'Non stop 8+ hour mixes of our most populer sleep audio',
                            style: TextStyle(
                              color: ThemeConfigs.color2,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                  
                          SizedBox(height: 20),
                  
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
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Two-Column Grid of Containers
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: MasonryGridView.builder(
                    physics: const ClampingScrollPhysics(),
                    gridDelegate:
                        const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    itemCount: containerData.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: AssetImage(
                                  containerData[index]["image"]!,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.only(left: 3),
                            child: Text(
                              containerText[index]["text"]!,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: ThemeConfigs.color2,
                              ),
                            ),
                          ),

                          const SizedBox(height: 2),

                          // description
                          Padding(
                            padding: const EdgeInsets.only(left: 3),
                            child: Text(
                              '45 MIN . SLEEP MUSIC',
                              style: TextStyle(
                                color: ThemeConfigs.color17,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
