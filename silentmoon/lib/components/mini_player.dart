import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentmoon/helpers/audio_helper.dart';

class MiniPlayer extends StatefulWidget {
  const MiniPlayer({super.key});

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer>
    with SingleTickerProviderStateMixin {
  final controller = Get.find<AudioController>();

  double top = 50;
  double right = 20;

  bool isExpanded = false;

  late AnimationController waveController;

  @override
  void initState() {
    super.initState();

    waveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
      return Positioned(
        top: top,
        right: right,
        child: GestureDetector(
          onPanUpdate: (details) {
            setState(() {
              top += details.delta.dy;
              right -= details.delta.dx; 
            });
          },
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: isExpanded ? 180 : 50,
            height: isExpanded ? 55 : 50,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 165, 171, 255),
              borderRadius: BorderRadius.circular(isExpanded ? 15 : 50),
            ),
            child: isExpanded ? _buildExpanded() : _buildCircle(),
          ),
        ),
      );
  }

  // Circle UI with wave
  Widget _buildCircle() {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Wave animation
          AnimatedBuilder(
            animation: waveController,
            builder: (context, child) {
              return Container(
                width: 50 + (waveController.value * 20),
                height: 50 + (waveController.value * 20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color.fromARGB(255, 1, 0, 71).withOpacity(
                    0.2 - (waveController.value * 0.2),
                  ),
                ),
              );
            },
          ),

          const Icon(
            Icons.music_note,
            color: Colors.white,
            size: 20,
          ),
        ],
      ),
    );
  }

  // Expanded UI
  Widget _buildExpanded() {
    return Row(
      children: [
        Obx(
          () => IconButton(
            icon: Icon(
              controller.isPlaying.value ? Icons.pause : Icons.play_arrow,
              color: Colors.white,
            ),
            onPressed: controller.toggleMusic,
          ),
        ),

        Expanded(
          child: Obx(
            () => Slider(
              value: controller.volume.value,
              min: 0,
              max: 1,
              onChanged: controller.setVolume,
            ),
          ),
        ),
      ],
    );
  }
}
