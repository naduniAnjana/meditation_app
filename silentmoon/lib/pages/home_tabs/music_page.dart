import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:silentmoon/app/configs/theme.dart';
import 'package:silentmoon/model/morning_model.dart';
import 'package:silentmoon/pages/music/meditation.dart';

class MusicPage extends StatefulWidget {
  const MusicPage({super.key});

  @override
  State<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  late List<Map<String, dynamic>> containerData;

  int selectedIndex = 0;

  final List<double> containerHeights = [180, 120, 140, 200, 160, 220, 170];

  final List<MorningModel> morningMeditation = [
    MorningModel(
      title: "Morning Clarity",
      artist: "JackCatorBooks",
      image: "assets/images/morning/clarity.jpg",
      audio: "assets/audios/morning/morning-clarity.mp3",
      duration: "03:39",
    ),
    MorningModel(
      title: "Early Morning Meditation",
      artist: "Universe_Bella",
      image: "assets/images/morning/early.jpg",
      audio: "assets/audios/morning/early-morning.mp3",
      duration: "02:56",
    ),
    MorningModel(
      title: "Morning Meditation",
      artist: "FASSounds",
      image: "assets/images/morning/meditation.jpg",
      audio: "assets/audios/morning/morning-meditation.mp3",
      duration: "05:43",
    ),
    MorningModel(
      title: "Morning Relaxing",
      artist: "Onetent",
      image: "assets/images/morning/relaxing.jpg",
      audio: "assets/audios/morning/morning-relaxing.mp3",
      duration: "05:52",
    ),
    MorningModel(
      title: "Rainy Morning Meditation",
      artist: "Siarhei_Korbut",
      image: "assets/images/morning/rainy.jpg",
      audio: "assets/audios/morning/rainy-morning.mp3",
      duration: "05:00",
    ),
  ];

  final List<MorningModel> deepBreathing = [
    MorningModel(
      title: "Early Morning Meditation",
      artist: "Universe_Bella",
      image: "assets/images/morning/early.jpg",
      audio: "assets/audios/morning/early-morning.mp3",
      duration: "02:56",
    ),
  ];

  final List<MorningModel> sleepBetter = [
    MorningModel(
      title: "Morning Meditation",
      artist: "FASSounds",
      image: "assets/images/morning/meditation.jpg",
      audio: "assets/audios/morning/morning-meditation.mp3",
      duration: "05:43",
    ),
  ];

  final List<MorningModel> calmMind = [
    MorningModel(
      title: "Morning Relaxing",
      artist: "Onetent",
      image: "assets/images/morning/relaxing.jpg",
      audio: "assets/audios/morning/morning-relaxing.mp3",
      duration: "05:52",
    ),
  ];

  final List<MorningModel> dailyGratitude = [
    MorningModel(
      title: "Rainy Morning Meditation",
      artist: "Siarhei_Korbut",
      image: "assets/images/morning/rainy.jpg",
      audio: "assets/audios/morning/rainy-morning.mp3",
      duration: "05:00",
    ),
  ];

  final List<MorningModel> stressRelief = [
    MorningModel(
      title: "Rainy Morning Meditation",
      artist: "Siarhei_Korbut",
      image: "assets/images/morning/rainy.jpg",
      audio: "assets/audios/morning/rainy-morning.mp3",
      duration: "05:00",
    ),
  ];

  final List<MorningModel> mindReset = [
    MorningModel(
      title: "Rainy Morning Meditation",
      artist: "Siarhei_Korbut",
      image: "assets/images/morning/rainy.jpg",
      audio: "assets/audios/morning/rainy-morning.mp3",
      duration: "05:00",
    ),
  ];

  @override
  void initState() {
    super.initState();

    containerData = [
      {"image": 'assets/images/app/image1.png',"text": "Morning Meditation","playlist": morningMeditation,},
      {"image": 'assets/images/app/image2.png',"text": "Deep Breathing","playlist": deepBreathing,},
      {"image": 'assets/images/app/image3.jpg',"text": "Calm Your Mind","playlist": calmMind,},
      {"image": 'assets/images/app/image4.jpg',"text": "Sleep Better","playlist": sleepBetter,},
      {"image": 'assets/images/app/image5.jpg',"text": "Daily Gratitude","playlist": dailyGratitude,},
      {"image": 'assets/images/app/image6.jpg',"text": "Stress Relief","playlist": stressRelief,},
      {"image": 'assets/images/app/image7.jpg',"text": "Mind Reset","playlist": mindReset,},
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
                            playlist: containerData[index]["playlist"],
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
