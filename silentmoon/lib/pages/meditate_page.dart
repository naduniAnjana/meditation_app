import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:silentmoon/app/configs/theme.dart';

void main() {
  runApp(const MaterialApp(home: MeditatePage()));
}

class MeditatePage extends StatefulWidget {
  const MeditatePage({super.key});

  @override
  State<MeditatePage> createState() => _MeditatePageState();
}

class _MeditatePageState extends State<MeditatePage> {
  final AudioRecorder _recorder = AudioRecorder();
  final FlutterTts _tts = FlutterTts();
  
  String _status = "Tap mic to speak";
  bool _isSpeaking = false;

  @override
  void initState() {
    super.initState();
    _initTts();
    _requestPermissions();
  }

  void _initTts() {
    _tts.setStartHandler(() => setState(() => _isSpeaking = true));
    _tts.setCompletionHandler(() => setState(() {
      _isSpeaking = false;
      _status = "Tap mic to speak";
    }));
  }

  Future<void> _requestPermissions() async {
    await Permission.microphone.request();
  }

  // Record Audio
  Future<String?> _record() async {
    final dir = await getTemporaryDirectory();
    final path = '${dir.path}/input.wav';

    if (await _recorder.hasPermission()) {
      await _recorder.start(
        const RecordConfig(encoder: AudioEncoder.wav, sampleRate: 16000),
        path: path,
      );
      
      await Future.delayed(const Duration(seconds: 3));
      return await _recorder.stop();
    }
    return null;
  }

  // Send to Backend & Get AI Response
  Future<String> _getAIResponse(String audioPath) async {
    final uri = Uri.parse('http://192.168.1.168:8000/predict');
    var request = http.MultipartRequest('POST', uri);
    request.files.add(await http.MultipartFile.fromPath('file', audioPath));

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['ai_response']; 
    } else {
      throw Exception("Server Error");
    }
  }

  // Main Action Function
  Future<void> _handleInteraction() async {
    try {
      setState(() => _status = "Listening...");
      final path = await _record();

      if (path != null) {
        setState(() => _status = "AI is thinking...");
        final responseText = await _getAIResponse(path);

        setState(() => _status = "AI Speaking...");
        await _tts.setSpeechRate(0.4); 
        await _tts.speak(responseText);
      }
    } catch (e) {
      setState(() => _status = "Error: Try again");
      debugPrint(e.toString());
    }
  }

  @override
  void dispose() {
    _recorder.dispose();
    _tts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      body: Center(
        child: Column(
          children: [
            // Topic
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 50),
                child: Text(
                  "Meditation ",
                  style: TextStyle(
                    color: ThemeConfigs.color19,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: const Text(
                "Hi, I'm SilentMoon. You can share your feelings with the mic, and I'm here to listen and talk with you.  Let's talk together",
                textAlign: TextAlign.center,
                style: TextStyle(color: ThemeConfigs.color25),
              ),
            ),
            const SizedBox(height: 90),
            // Status Text
            Text(
              _status,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: ThemeConfigs.color20),
            ),
            const SizedBox(height: 40),

            // Animated Mic/Stop Button
            GestureDetector(
              onTap: _isSpeaking ? () => _tts.stop() : _handleInteraction,
              child: Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: _isSpeaking ? ThemeConfigs.color31 : ThemeConfigs.color3,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 2)],
                ),
                child: Icon(
                  _isSpeaking ? Icons.stop : Icons.mic,
                  size: 60,
                  color: Colors.white,
                ),
              ),
            ),

            if (_isSpeaking)
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  "Tap button to stop AI",
                  style: TextStyle(color: Colors.grey),
                ),
              ),

            const SizedBox(height: 50),

            // Lottie animation below mic
            Lottie.asset(
              'assets/images/app/yoga.json',
              width: 390,
              height: 290,
              repeat: true,
            ),
          ],
        ),
      ),
    );
  }
}