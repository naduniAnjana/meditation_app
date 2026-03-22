import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:silentmoon/app/configs/theme.dart';
import 'package:silentmoon/model/morning_model.dart';
import 'package:silentmoon/pages/music/sleep_song_screen.dart';

class SleepPage extends StatefulWidget {
  const SleepPage({super.key});

  @override
  State<SleepPage> createState() => _SleepPageState();
}

class _SleepPageState extends State<SleepPage> {
  late List<Map<String, dynamic>> containerData;

  final List<MorningModel> morningMeditation = [
    MorningModel(
      title: "Morning Clarity",
      artist: "JackCatorBooks",
      image: "assets/images/music/clarity.jpg",
      audio: "assets/audios/music/morning-clarity.mp3",
      duration: "03:39",
    ),
    MorningModel(
      title: "Early Morning Meditation",
      artist: "Universe_Bella",
      image: "assets/images/music/early.jpg",
      audio: "assets/audios/music/early-morning.mp3",
      duration: "02:56",
    ),
    MorningModel(
      title: "Morning Meditation",
      artist: "FASSounds",
      image: "assets/images/music/meditation.jpg",
      audio: "assets/audios/music/morning-meditation.mp3",
      duration: "05:43",
    ),
    MorningModel(
      title: "Morning Relaxing",
      artist: "Onetent",
      image: "assets/images/music/relaxing.jpg",
      audio: "assets/audios/music/morning-relaxing.mp3",
      duration: "05:52",
    ),
    MorningModel(
      title: "Rainy Morning Meditation",
      artist: "Siarhei_Korbut",
      image: "assets/images/music/rainy.jpg",
      audio: "assets/audios/music/rainy-morning.mp3",
      duration: "05:00",
    ),
  ];

  final List<MorningModel> deepBreathing = [
    MorningModel(
      title: "Early Morning Meditation",
      artist: "Universe_Bella",
      image: "assets/images/music/early.jpg",
      audio: "assets/audios/music/early-morning.mp3",
      duration: "02:56",
    ),
  ];

  final List<MorningModel> sleepBetter = [
    MorningModel(
      title: "Morning Meditation",
      artist: "FASSounds",
      image: "assets/images/music/meditation.jpg",
      audio: "assets/audios/music/morning-meditation.mp3",
      duration: "05:43",
    ),
  ];

  final List<MorningModel> calmMind = [
    MorningModel(
      title: "Morning Relaxing",
      artist: "Onetent",
      image: "assets/images/music/relaxing.jpg",
      audio: "assets/audios/music/morning-relaxing.mp3",
      duration: "05:52",
    ),
  ];

  final List<MorningModel> dailyGratitude = [
    MorningModel(
      title: "Rainy Morning Meditation",
      artist: "Siarhei_Korbut",
      image: "assets/images/music/rainy.jpg",
      audio: "assets/audios/music/rainy-morning.mp3",
      duration: "05:00",
    ),
  ];

  final List<MorningModel> stressRelief = [
    MorningModel(
      title: "Rainy Morning Meditation",
      artist: "Siarhei_Korbut",
      image: "assets/images/music/rainy.jpg",
      audio: "assets/audios/music/rainy-morning.mp3",
      duration: "05:00",
    ),
  ];

  final List<MorningModel> mindReset = [
    MorningModel(
      title: "Rainy Morning Meditation",
      artist: "Siarhei_Korbut",
      image: "assets/images/music/rainy.jpg",
      audio: "assets/audios/music/rainy-morning.mp3",
      duration: "05:00",
    ),
  ];

  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    containerData = [
      {"image": 'assets/images/app/sleep1.png',"text": "NIght Island","playlist": morningMeditation,},
      {"image": 'assets/images/app/sleep2.png',"text": "Sweet Sleep","playlist": deepBreathing,},
      {"image": 'assets/images/app/sleep3.jpg',"text": "Calm Your Mind","playlist": calmMind,},
      {"image": 'assets/images/app/sleep4.png',"text": "Sleep Better","playlist": sleepBetter,},
      {"image": 'assets/images/app/sleep5.jpg',"text": "Daily Gratitude","playlist": dailyGratitude,},
      {"image": 'assets/images/app/sleep6.jpg',"text": "Stress Relief","playlist": stressRelief,},
      {"image": 'assets/images/app/sleep7.png',"text": "Mind Reset","playlist": mindReset,},
      {"image": 'assets/images/app/sleep8.png',"text": "Mind Reset","playlist": mindReset,},
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF092E77),
      body: Stack(
        children: [
          Opacity(
            opacity: 0.2,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/app/night.jpg'),
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

              const SizedBox(height: 25),

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
                        image: AssetImage('assets/images/app/background4.jpg'),
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
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: MasonryGridView.builder(
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    itemCount: containerData.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => SleepSongScreen(
                                title: containerData[index]["text"],
                                playlist: containerData[index]["playlist"],
                              ),
                            ),
                          );
                        },
                        child: Column(
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
                                containerData[index]["text"]!,
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
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }
}
