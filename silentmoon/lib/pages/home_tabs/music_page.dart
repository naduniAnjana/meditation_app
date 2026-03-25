import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:silentmoon/app/configs/theme.dart';
import 'package:silentmoon/pages/music/meditation_songs_screen.dart';

class MusicPage extends StatefulWidget {
  const MusicPage({super.key});

  @override
  State<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  late List<Map<String, dynamic>> containerData;

  int selectedIndex = 0;

  final List<double> containerHeights = [180, 120, 140, 200, 160, 220, 170];

  @override
  void initState() {
    super.initState();

    containerData = [
      {"image": 'assets/images/app/image1.png',"text": "Morning Meditation"},
      {"image": 'assets/images/app/image2.png',"text": "Deep Breathing"},
      {"image": 'assets/images/app/image3.jpg',"text": "Calm Your Mind"},
      {"image": 'assets/images/app/image4.jpg',"text": "Sleep Better"},
      {"image": 'assets/images/app/image5.jpg',"text": "Daily Gratitude"},
      {"image": 'assets/images/app/image6.jpg',"text": "Stress Relief"},
      {"image": 'assets/images/app/image7.jpg',"text": "Mind Reset"},
    ];
  }

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

          const SizedBox(height: 25),

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

          // Daily Calm Container
          Padding(
            padding: const EdgeInsets.only(top: 25, left: 20, right: 20),
            child: Container(
              width: double.infinity,
              height: 110,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/app/Daily.jpg'),
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
                      onTap: () {},
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

          const SizedBox(height: 30),

          // Two-Column Grid of Containers
          Expanded(
            child: MasonryGridView.builder(
              padding: EdgeInsets.zero,
              physics: const ClampingScrollPhysics(),
              gridDelegate:
                  const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
              mainAxisSpacing: 15,
              itemCount: containerData.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Meditation(
                            title: containerData[index]["text"],
                            category: containerData[index]["text"],
                          ),
                        ),
                      );
                    },
                    child: Stack(
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
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
