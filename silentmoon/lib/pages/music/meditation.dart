import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:silentmoon/app/configs/theme.dart';
import 'package:silentmoon/model/morning_model.dart';

enum RepeatMode { off, all, one }
class Meditation extends StatefulWidget {
  const Meditation({super.key});

  @override
  State<Meditation> createState() => _MeditationState();
}

class _MeditationState extends State<Meditation> {
  double progress = 0.0;
  bool isPlaying = false;

  final AudioPlayer _audioPlayer = AudioPlayer();
  int currentIndex = 0;

  Duration position = Duration.zero;
  Duration duration = Duration.zero;

  RepeatMode repeatMode = RepeatMode.off;

  final List<MorningModel> playlist = [
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

  @override
  void initState() {
    super.initState();

    // Listen to current position
    _audioPlayer.onPositionChanged.listen((Duration p) {
      setState(() {
        position = p;
      });
    });

    // Listen to total duration
    _audioPlayer.onDurationChanged.listen((Duration d) {
      setState(() {
        duration = d;
      });
    });

    // Listen to audio completion
    _audioPlayer.onPlayerComplete.listen((event) {
      if (repeatMode == RepeatMode.one) {
        playAudio(currentIndex);
      } else if (repeatMode == RepeatMode.all) {
        playNext();
      } else {
        setState(() {
          isPlaying = false;
          position = Duration.zero;
        });
      }
    });
  }

  Future<void> playAudio(int index) async {
    final track = playlist[index];

    if (currentIndex != index) {
      await _audioPlayer.stop();
      currentIndex = index;
      position = Duration.zero;
      isPlaying = false;
    }

    if (isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play(
        AssetSource(track.audio.replaceFirst('assets/', '')),
      );
    }

    setState(() {
      isPlaying = !isPlaying;
    });
  }

  String formatTime(Duration d) {
    final minutes = d.inMinutes.toString().padLeft(2, '0');
    final seconds = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  void playNext() {
    int nextIndex = currentIndex + 1;
    if (nextIndex >= playlist.length) nextIndex = 0;
    playAudio(nextIndex);
  }

  void playPrevious() {
    int prevIndex = currentIndex - 1;
    if (prevIndex < 0) prevIndex = playlist.length - 1;
    playAudio(prevIndex);
  }

   void toggleRepeat() {
      setState(() {
        switch (repeatMode) {
          case RepeatMode.off:
            repeatMode = RepeatMode.all;
            break;
          case RepeatMode.all:
            repeatMode = RepeatMode.one;
            break;
          case RepeatMode.one:
            repeatMode = RepeatMode.off;
            break;
        }
      });
    }

  @override
  Widget build(BuildContext context) {
    final currentTrack = playlist[currentIndex];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Now Playing',
          style: TextStyle(
            color: ThemeConfigs.color19,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 10,right: 30),
            child: Column(
              children: [
                // Gradient Container
                Container(
                  height: 340,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF9C27B0), 
                        Color(0xFF2196F3)
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 12,
                        offset: const Offset(0, 6), 
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                    child: Column(
                      children: [
                        // Audio Image
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            image: DecorationImage(
                              image: AssetImage(currentTrack.image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
            
                        // Song Name
                        Text(
                          currentTrack.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: ThemeConfigs.color2
                          ),
                        ),
                        const SizedBox(height: 8),
            
                        // Artist Name
                        Text(
                          currentTrack.artist,
                          style: TextStyle(
                            fontSize: 14, 
                            color: ThemeConfigs.color2
                          ),
                        ),
            
                        // Progress Bar
                        Slider(
                          min: 0,
                          max: duration.inSeconds.toDouble() > 0 ? duration.inSeconds.toDouble() : 1,
                          value: position.inSeconds.toDouble().clamp(0, duration.inSeconds.toDouble()),
                          onChanged: (value) async{
                            await _audioPlayer.seek(Duration(seconds: value.toInt()));
                            setState(() {
                              position = Duration(seconds: value.toInt());
                            });
                          },
                          activeColor: ThemeConfigs.color2,
                          inactiveColor: Colors.grey.shade300,
                        ),
            
                        // Time Duration
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 22),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(formatTime(position)),
                              Text(currentTrack.duration),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
            
                        // Control Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Repeat
                            IconButton(
                              iconSize: 26,
                              icon: Icon(
                                repeatMode == RepeatMode.off
                                    ? Icons.repeat 
                                    : repeatMode == RepeatMode.all
                                    ? Icons.repeat
                                    : Icons.repeat_one,
                                color: ThemeConfigs.color2,
                              ),
                              onPressed: toggleRepeat,
                            ),
                            const SizedBox(width: 25),
            
                            // Backward
                            IconButton(
                              iconSize: 35,
                              icon: const Icon(Icons.skip_previous),
                              onPressed: playPrevious,
                            ),
            
                            const SizedBox(width: 15),
            
                            // Play / Pause
                            GestureDetector(
                              onTap: () => playAudio(currentIndex),
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF2196F3),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.25),
                                      blurRadius: 12,
                                      offset: const Offset(0, 6),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  isPlaying ? Icons.pause : Icons.play_arrow,
                                  color: Colors.white,
                                  size: 25,
                                ),
                              ),
                            ),
            
                            const SizedBox(width: 15),
            
                            // Forward
                            IconButton(
                              iconSize: 35,
                              icon: const Icon(Icons.skip_next),
                              onPressed: playNext, 
                            ),
                            const SizedBox(width: 25),
            
                            // Favorite
                            IconButton(
                              iconSize: 25,
                              icon: const Icon(
                                PhosphorIconsBold.heartStraight,
                                color: ThemeConfigs.color2,
                              ),
                              onPressed: () {},
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
          const SizedBox(height: 40),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Music Playlist',
                    style: TextStyle(
                      color: ThemeConfigs.color18,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ...List.generate(playlist.length, (index) {
                            final item = playlist[index];
                            final isCurrentPlaying =
                                (index == currentIndex && isPlaying);

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: playlistItem(
                                color: isCurrentPlaying
                                    ? const Color.fromARGB(255, 241, 220, 255)
                                    : ThemeConfigs.color30,
                                image: item.image,
                                title: item.title,
                                artist: item.artist,
                                duration: item.duration,
                                index: index,
                              ),
                            );
                          }),
                          const SizedBox(height: 30), 
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget playlistItem({
    required Color color,
    required String image,
    required String title,
    required String artist,
    required String duration,
    required int index,
  }) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.25),
        //     blurRadius: 12,
        //     offset: const Offset(0, 6),
        //   ),
        // ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w500)),
              Text(artist,
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w400)),
              Text(duration, style: const TextStyle(fontSize: 11)),
              ],
            ),
            const Spacer(),
            IconButton(
              icon: Icon(
                isPlaying && currentIndex == index
                    ? Icons.pause
                    : Icons.play_arrow,
              ),
              onPressed: () => playAudio(index),
            ),
          ],
        ),
      ),
    );
  }
}
