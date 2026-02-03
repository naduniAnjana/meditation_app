// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_tts/flutter_tts.dart';
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:record/record.dart';

// class MeditatePage extends StatefulWidget {
//   const MeditatePage({super.key});

//   @override
//   State<MeditatePage> createState() => _MeditatePageState();
// }

// class _MeditatePageState extends State<MeditatePage> {
//   final AudioRecorder recorder = AudioRecorder();
//   final flutterTts = FlutterTts();
//   String status = "Tap mic to speak";

//   @override
//   void initState() {
//     super.initState();
//     requestMicPermission();

//     flutterTts.setCompletionHandler(() {
//       setState(() {
//         status = "Tap mic to speak";
//       });
//     });
//   }

//   @override
//   void dispose() {
//     recorder.dispose();
//     super.dispose();
//   }

//   // Request microphone permission
//   Future<void> requestMicPermission() async {
//     await Permission.microphone.request();
//   }

//   // Record audio
//   Future<String> recordAudio() async {
//     final dir = await getTemporaryDirectory();
//     final path = '${dir.path}/input.wav';

//     await recorder.start(
//       const RecordConfig(
//         encoder: AudioEncoder.wav,
//         bitRate: 128000,
//         sampleRate: 16000,
//       ),
//       path: path,
//     );

//     await Future.delayed(const Duration(seconds: 3));
//     await recorder.stop();

//     return path;
//   }

//   // Send audio to backend
//   Future<String> sendAudio(String path) async {
//     final request = http.MultipartRequest(
//       'POST',
//       Uri.parse('http://192.168.1.168:8000/predict'),
//     );

//     request.files.add(await http.MultipartFile.fromPath('file', path));

//     final response = await request.send();
//     final body = await response.stream.bytesToString();

//     // return jsonDecode(body)['emotion'];
//     return jsonDecode(body)['emotion'].toString().trim().toLowerCase();
//   }

//   // Speak emotion
//   Future<void> speakEmotion(String emotion) async {
//     String text;

//     debugPrint("Emotion received from backend: '$emotion'");

//     switch (emotion) {
//       case 'ang':
//         text = "I hear some anger. Let's take a deep breath together.";
//         break;
//       case 'hap':
//         text = "You sound happy! That's wonderful.";
//         break;
//       case 'sad':
//         text = "I sense you are feeling sad. I'm here for you.";
//         break;
//       case 'neu':
//         text = "You sound neutral.";
//         break;
//       case 'fea':
//         text = "I sense fear. Let's take a moment to calm down.";
//         break;
//       case 'dis':
//         text = "I hear some disgust. Let's relax a bit.";
//         break;
//       default:
//         text = "Thank you for sharing how you feel.";
//     }

//     await flutterTts.setSpeechRate(0.45);
//     await flutterTts.setPitch(1.0);
//     await flutterTts.speak(text);
//   }

//   // Function for button
//   Future<void> onMicPressed() async {
//     try {
//       setState(() {
//         status = "Listening...";
//       });

//       final audioPath = await recordAudio();

//       // give UI a moment
//       await Future.delayed(const Duration(milliseconds: 300));

//       setState(() {
//         status = "Analyzing...";
//       });

//       final emotion = await sendAudio(audioPath);

//       await Future.delayed(const Duration(milliseconds: 300));

//       setState(() {
//         status = "Speaking...";
//       });

//       await speakEmotion(emotion);

//       setState(() {
//         status = "Tap mic to speak";
//       });
//     } catch (e) {
//       setState(() {
//         status = "Something went wrong";
//       });
//       debugPrint(e.toString());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Meditate Page')),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(status, style: const TextStyle(fontSize: 18)),
//           const SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: onMicPressed,
//             child: const Icon(Icons.mic, size: 50),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

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

  // 1. Record Audio (3 seconds)
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

  // 2. Send to Backend & Get AI Response
  Future<String> _getAIResponse(String audioPath) async {
    final uri = Uri.parse('http://192.168.1.168:8000/predict'); // Update with your IP
    var request = http.MultipartRequest('POST', uri);
    request.files.add(await http.MultipartFile.fromPath('file', audioPath));

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['ai_response']; // This comes from Gemini in the backend
    } else {
      throw Exception("Server Error");
    }
  }

  // 3. Main Action Function
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
      backgroundColor: const Color(0xFFF0F4F8), // Calm blue-grey
      appBar: AppBar(title: const Text("Emotional Support AI"), backgroundColor: Colors.teal),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Status Text
            Text(_status, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w300)),
            const SizedBox(height: 40),

            // Animated Mic/Stop Button
            GestureDetector(
              onTap: _isSpeaking ? () => _tts.stop() : _handleInteraction,
              child: Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: _isSpeaking ? Colors.redAccent : Colors.teal,
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
                child: Text("Tap button to stop AI", style: TextStyle(color: Colors.grey)),
              ),
          ],
        ),
      ),
    );
  }
}