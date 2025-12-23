import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:silentmoon/app/configs/theme.dart';

class Meditation extends StatefulWidget {
  const Meditation({super.key});

  @override
  State<Meditation> createState() => _MeditationState();
}

class _MeditationState extends State<Meditation> {
  double progress = 0.3;
  bool isPlaying = false;
  
  @override
  Widget build(BuildContext context) {
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
                            image: const DecorationImage(
                              image: AssetImage("assets/image1.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
            
                        // Song Name
                        const Text(
                          "Morning Meditation",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: ThemeConfigs.color2
                          ),
                        ),
                        const SizedBox(height: 8),
            
                        // Artist Name
                        const Text(
                          "Silent Moon",
                          style: TextStyle(
                            fontSize: 14, 
                            color: ThemeConfigs.color2
                          ),
                        ),
            
                        // Progress Bar
                        Slider(
                          value: progress,
                          onChanged: (value) {
                            setState(() {
                              progress = value;
                            });
                          },
                          activeColor: ThemeConfigs.color2,
                          inactiveColor: Colors.grey.shade300,
                        ),
            
                        // Time Duration
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 22),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [Text("01:20"), Text("05:00")],
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
                              icon: const Icon(Icons.repeat),
                              color: ThemeConfigs.color2,
                              onPressed: () {},
                            ),
                            const SizedBox(width: 25),
            
                            // Backward
                            IconButton(
                              iconSize: 35,
                              icon: const Icon(Icons.skip_previous),
                              onPressed: () {},
                            ),
            
                            const SizedBox(width: 15),
            
                            // Play / Pause
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isPlaying = !isPlaying;
                                });
                              },
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
                              onPressed: () {},
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
                          playlistItem(
                            color: const Color(0xFFDCF1FF),
                            image: "assets/image1.png",
                          ),
                          const SizedBox(height: 12),
                          playlistItem(
                            color: const Color(0xFFDCF1FF),
                            image: "assets/image2.png",
                          ),
                          const SizedBox(height: 12),
                          playlistItem(
                            color: const Color(0xFFDCF1FF),
                            image: "assets/image2.png",
                          ),
                          const SizedBox(height: 12),
                          playlistItem(
                            color: const Color(0xFFDCF1FF),
                            image: "assets/image2.png",
                          ),
                          const SizedBox(height: 12),
                          playlistItem(
                            color: const Color(0xFFDCF1FF),
                            image: "assets/image2.png",
                          ),
                          const SizedBox(height: 40),
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
  }) {
    return Container(
      height: 90,
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
        padding: const EdgeInsets.all(15),
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
              children: const [
                Text("Morning Meditation",
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                Text("Silent Moon",
                    style:
                        TextStyle(fontSize: 13, fontWeight: FontWeight.w400)),
                Text("05:00", style: TextStyle(fontSize: 11)),
              ],
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                setState(() { isPlaying = !isPlaying; });
              },
              child: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
                size: 28,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
