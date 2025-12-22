import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:silentmoon/app/configs/theme.dart';

class MusicPage extends StatefulWidget {
  const MusicPage({super.key});

  @override
  State<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
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

  // List of container heights
  final List<double> containerHeights = [180, 120, 140, 200, 160, 220, 170];

  final List<Map<String, String>> containerData = [
    {"image": 'assets/image1.png', "text": "Morning Meditation"},
    {"image": 'assets/image2.png', "text": "Deep Breathing"},
    {"image": 'assets/image3.jpg', "text": "Calm Your Mind"},
    {"image": 'assets/image4.jpg', "text": "Sleep Better"},
    {"image": 'assets/image5.jpg', "text": "Daily Gratitude"},
    {"image": 'assets/image6.jpg', "text": "Stress Relief"},
    {"image": 'assets/image7.jpg', "text": "Stress Relief"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Topic
          const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 50),
              child: Text(
                "Music",
                style: TextStyle(
                  color: ThemeConfigs.color19,
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
              "We can learn how to recognize when our minds are doing their normal everyday acrobatics.",
              textAlign: TextAlign.center,
              style: TextStyle(color: ThemeConfigs.color20),
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
                                    : ThemeConfigs.color21,
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
                                    ? ThemeConfigs.color14
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

          // Daily Calm Container
          Padding(
            padding: const EdgeInsets.only(top: 25, left: 20, right: 20),
            child: Container(
              width: double.infinity,
              height: 110,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/Daily.jpg'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Topic
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Daily Calm',
                          style: TextStyle(
                            color: ThemeConfigs.color19,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 10),
                        // Description
                        Text(
                          'APR 30 * PAUSE PRACTICE',
                          style: TextStyle(
                            color: ThemeConfigs.color22,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(width: 30),

                    // Button
                    GestureDetector(
                      onTap: () {
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: ThemeConfigs.color19,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.play_arrow,
                            color: ThemeConfigs.color2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 15),

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
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                itemCount: containerData.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: containerHeights[index],
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: AssetImage(containerData[index]["image"]!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          containerData[index]["text"]!,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: ThemeConfigs.color2,
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
    );
  }
}