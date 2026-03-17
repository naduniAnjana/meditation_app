import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class AudioController extends GetxController {
  final AudioPlayer player = AudioPlayer();

  var isPlaying = false.obs;
  var volume = 0.3.obs;

  @override
  void onInit() {
    super.onInit();
    initAudio();
  }

  Future<void> initAudio() async {
    try {
      await player.setAsset('assets/audios/morning/morning-clarity.mp3');
      player.setLoopMode(LoopMode.one);
      player.setVolume(volume.value);
    } catch (e) {
      print("Audio Error: $e");
    }
  }

  void playMusic() {
    player.play();
    isPlaying.value = true;
  }

  void pauseMusic() {
    player.pause();
    isPlaying.value = false;
  }

  void toggleMusic() {
    if (isPlaying.value) {
      pauseMusic();
    } else {
      playMusic();
    }
  }

  void setVolume(double value) {
    volume.value = value;
    player.setVolume(value);
  }

  @override
  void onClose() {
    player.dispose();
    super.onClose();
  }
}