import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:silentmoon/app/configs/theme.dart';
import 'package:silentmoon/model/morning_model.dart';
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

  final List<MorningModel> morningMeditation = [
    MorningModel(
      title: "Morning Clarity",
      artist: "JackCatorBooks",
      image: "assets/images/music/clarity.jpg",
      audio: "assets/audios/music/morning-clarity.mp3",
      duration: "3:39",
    ),
    MorningModel(
      title: "Early Morning Meditation",
      artist: "Universe_Bella",
      image: "assets/images/music/early.jpg",
      audio: "assets/audios/music/early-morning.mp3",
      duration: "2:56",
    ),
    MorningModel(
      title: "Morning Meditation",
      artist: "FASSounds",
      image: "assets/images/music/meditation.jpg",
      audio: "assets/audios/music/morning-meditation.mp3",
      duration: "5:43",
    ),
    MorningModel(
      title: "Morning Relaxing",
      artist: "Onetent",
      image: "assets/images/music/relaxing.jpg",
      audio: "assets/audios/music/morning-relaxing.mp3",
      duration: "5:52",
    ),
    MorningModel(
      title: "Rainy Morning Meditation",
      artist: "Siarhei_Korbut",
      image: "assets/images/music/rainy.jpg",
      audio: "assets/audios/music/rainy-morning.mp3",
      duration: "5:00",
    ),
  ];

  final List<MorningModel> deepBreathing = [
    MorningModel(
      title: "Breathing for Mindfulness",
      artist: "AmbiNet",
      image: "assets/images/music/ambient.jpeg",
      audio: "assets/audios/music/ambinet-breathing.mp3",
      duration: "4:20",
    ),
    MorningModel(
      title: "Infinite Breaths",
      artist: "BreakzStudios",
      image: "assets/images/music/infinite.jpg",
      audio: "assets/audios/music/infinite-breathing.mp3",
      duration: "27:08",
    ),
    MorningModel(
      title: "Breathing Meditation",
      artist: "The_Mountain",
      image: "assets/images/music/mountain.jpg",
      audio: "assets/audios/music/mountain-breathing.mp3",
      duration: "2:54",
    ),
    MorningModel(
      title: "Breath of Enlightenment",
      artist: "Grand_Project",
      image: "assets/images/music/project.jpg",
      audio: "assets/audios/music/project-breathing.mp3",
      duration: "2:54",
    ),
  ];

  final List<MorningModel> sleepBetter = [
    MorningModel(
      title: "Sleep",
      artist: "Armónicamente",
      image: "assets/images/music/armonic.jpg",
      audio: "assets/audios/music/armonic-sleep.mp3",
      duration: "12:45",
    ),
    MorningModel(
      title: "Peaceful Sleep",
      artist: "Good_B_Music",
      image: "assets/images/music/peaceful.jpg",
      audio: "assets/audios/music/peaceful-sleep.mp3",
      duration: "5:00",
    ),
    MorningModel(
      title: "Relaxing Sleep Music",
      artist: "DesiFreeMusic",
      image: "assets/images/music/relaxing.jpg",
      audio: "assets/audios/music/relaxing-sleep.mp3",
      duration: "2:17",
    ),
    MorningModel(
      title: "Better Devotion",
      artist: "KOKOSHUNGSAN-NET",
      image: "assets/images/music/better.jpg",
      audio: "assets/audios/music/better-sleep.mp3",
      duration: "3:20",
    ),
    MorningModel(
      title: "Sleep Music for Stress Relief",
      artist: "VFS_World",
      image: "assets/images/music/sleep.jpg",
      audio: "assets/audios/music/sleep-music.mp3",
      duration: "3:20",
    ),
  ];

  final List<MorningModel> calmMind = [
    MorningModel(
      title: "Please Calm My Mind",
      artist: "music_for_video",
      image: "assets/images/music/mind.jpg",
      audio: "assets/audios/music/calm-mymind.mp3",
      duration: "2:55",
    ),
    MorningModel(
      title: "Ambient Mind",
      artist: "QuietPhase",
      image: "assets/images/music/amind.jpg",
      audio: "assets/audios/music/ambient-mind.mp3",
      duration: "5:33",
    ),
    MorningModel(
      title: "Relax Your Mind",
      artist: "RodrigoLCIR",
      image: "assets/images/music/relax.jpg",
      audio: "assets/audios/music/relax-mind.mp3",
      duration: "4:00",
    ),
    MorningModel(
      title: "Acoustic Calm world Music",
      artist: "Sonican",
      image: "assets/images/music/world.jpg",
      audio: "assets/audios/music/calm-world.mp3",
      duration: "1:52",
    ),
  ];

  final List<MorningModel> dailyGratitude = [
    MorningModel(
      title: "Transcendental Meditation",
      artist: "HigherUniversalMan",
      image: "assets/images/music/daily.jpeg",
      audio: "assets/audios/music/daily-meditation.mp3",
      duration: "6:19",
    ),
    MorningModel(
      title: "Daily Motivation Frequencies",
      artist: "Shemsh",
      image: "assets/images/music/motivation.jpg",
      audio: "assets/audios/music/daily-motivation.mp3",
      duration: "4:00",
    ),
    MorningModel(
      title: "Gratitude Mercy",
      artist: "Denis-Pavlov-Music",
      image: "assets/images/music/mercy.jpg",
      audio: "assets/audios/music/gratitude-mercy.mp3",
      duration: "5:07",
    ),
  ];

  final List<MorningModel> stressRelief = [
    MorningModel(
      title: "Stress Relief Background Music",
      artist: "CrystalEyeOfficial",
      image: "assets/images/music/relief.jpeg",
      audio: "assets/audios/music/relief-background.mp3",
      duration: "2:24",
    ),
    MorningModel(
      title: "Stress Relief Music Track 1",
      artist: "CrystalEyeOfficial",
      image: "assets/images/music/stress.jpeg",
      audio: "assets/audios/music/stress-background.mp3",
      duration: "2:30",
    ),
    MorningModel(
      title: "Stress Relief Music Track 2",
      artist: "CrystalEyeOfficial",
      image: "assets/images/music/rtrack.jpg",
      audio: "assets/audios/music/background-track.mp3",
      duration: "4:00",
    ),
    MorningModel(
      title: "Beautiful Stress Relief Ambient",
      artist: "Rockot",
      image: "assets/images/music/sambient.jpg",
      audio: "assets/audios/music/relief-ambient.mp3",
      duration: "5:02",
    ),
  ];

  final List<MorningModel> mindReset = [
    MorningModel(
      title: "Mind Reset Relaxing",
      artist: "JackCatorBooks",
      image: "assets/images/music/reset.jpg",
      audio: "assets/audios/music/reset-relaxing.mp3",
      duration: "3:02",
    ),
    MorningModel(
      title: "Tibetan Singing Bowl Sounds",
      artist: "MeditativeTiger",
      image: "assets/images/music/bowl.jpeg",
      audio: "assets/audios/music/mind-tibetan.mp3",
      duration: "2:33",
    ),
    MorningModel(
      title: "Peaceful Mind Reset",
      artist: "Damgaz",
      image: "assets/images/music/peacefulmind.jpg",
      audio: "assets/audios/music/peaceful-mind.mp3",
      duration: "4:04",
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
