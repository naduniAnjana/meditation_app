import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:silentmoon/app/configs/theme.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MeditatePage(),
  ));
}

class MeditatePage extends StatefulWidget {
  const MeditatePage({super.key});

  @override
  State<MeditatePage> createState() => _MeditatePageState();
}

class _MeditatePageState extends State<MeditatePage> {
  final AudioRecorder _recorder = AudioRecorder();
  final FlutterTts _tts = FlutterTts();
  final ScrollController _scrollController = ScrollController();

  String _status = "Tap mic to speak";
  bool _isSpeaking = false;
  bool _isLoading = false;
  String? _sessionId;

  final List<Map<String, String>> _messages = [];

  @override
  void initState() {
    super.initState();
    _initTts();
    _requestPermissions();

    _messages.add({
      "role": "assistant",
      "text":
          "Hi, I'm SilentMoon. You can share your feelings with me, and I will stay with you through the conversation."
    });
  }

  void _initTts() {
    _tts.setStartHandler(() {
      setState(() {
        _isSpeaking = true;
      });
    });

    _tts.setCompletionHandler(() {
      setState(() {
        _isSpeaking = false;
        _status = "Tap mic to speak";
      });
    });

    _tts.setCancelHandler(() {
      setState(() {
        _isSpeaking = false;
        _status = "Tap mic to speak";
      });
    });
  }

  Future<void> _requestPermissions() async {
    await Permission.microphone.request();
  }

  Future<String?> _record() async {
    final dir = await getTemporaryDirectory();
    final path = '${dir.path}/input.wav';

    if (await _recorder.hasPermission()) {
      await _recorder.start(
        const RecordConfig(
          encoder: AudioEncoder.wav,
          sampleRate: 16000,
          numChannels: 1,
        ),
        path: path,
      );

      setState(() => _status = "Listening...");
      await Future.delayed(const Duration(seconds: 4));

      final result = await _recorder.stop();

      if (result == null || !File(result).existsSync()) {
        throw Exception("Recording failed or file not created");
      }

      debugPrint("Recorded file path: $result");
      return result;
    }

    throw Exception("Microphone permission not granted");
  }

  Future<Map<String, dynamic>> _getAIResponse(String audioPath) async {
    // Change this IP to your backend IP
    final uri = Uri.parse('http://10.132.20.162:8000/predict');

    final request = http.MultipartRequest('POST', uri);

    request.files.add(
      await http.MultipartFile.fromPath('file', audioPath),
    );

    if (_sessionId != null) {
      request.fields['session_id'] = _sessionId!;
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    debugPrint("STATUS: ${response.statusCode}");
    debugPrint("BODY: ${response.body}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception("Server Error: ${response.body}");
    }
  }

  Future<void> _handleInteraction() async {
    if (_isLoading) return;

    try {
      setState(() {
        _isLoading = true;
        _status = "Preparing to listen...";
      });

      final path = await _record();

      if (path == null) {
        throw Exception("No audio recorded");
      }

      setState(() => _status = "AI is thinking...");

      final data = await _getAIResponse(path);

      if (data['error'] != null) {
        throw Exception(data['error']);
      }

      final sessionId = data['session_id']?.toString();
      final userText = data['user_text']?.toString() ?? "";
      final aiResponse = data['ai_response']?.toString() ?? "I am here with you.";
      final emotion = data['emotion']?.toString() ?? "unknown";

      setState(() {
        _sessionId = sessionId;

        if (userText.isNotEmpty) {
          _messages.add({
            "role": "user",
            "text": userText,
          });
        }

        _messages.add({
          "role": "assistant",
          "text": aiResponse,
        });

        _status = "AI Speaking...";
      });

      _scrollToBottom();

      await _tts.setSpeechRate(0.42);
      await _tts.setPitch(1.0);
      await _tts.speak(aiResponse);

      debugPrint("SESSION ID: $_sessionId");
      debugPrint("USER TEXT: $userText");
      debugPrint("EMOTION: $emotion");
      debugPrint("AI RESPONSE: $aiResponse");
    } catch (e) {
      debugPrint("FULL ERROR: $e");
      setState(() {
        _status = "Error: $e";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _clearConversation() async {
    try {
      if (_sessionId != null) {
        final uri = Uri.parse('http://10.132.20.162:8000/session/$_sessionId');
        await http.delete(uri);
      }
    } catch (_) {}

    await _tts.stop();

    setState(() {
      _sessionId = null;
      _isSpeaking = false;
      _status = "Tap mic to speak";
      _messages.clear();
      _messages.add({
        "role": "assistant",
        "text":
            "Hi, I'm SilentMoon. You can share your feelings with me, and I will stay with you through the conversation."
      });
    });

    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 120,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Widget _buildMessageBubble(Map<String, String> message) {
    final isUser = message["role"] == "user";

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isUser ? ThemeConfigs.color3 : Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              spreadRadius: 1,
            )
          ],
        ),
        child: Text(
          message["text"] ?? "",
          style: TextStyle(
            color: isUser ? Colors.white : ThemeConfigs.color20,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _recorder.dispose();
    _tts.stop();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Center(
          child: Column(
            children: [
              // Topic
              Padding(
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
              const SizedBox(height: 5),
        
              Lottie.asset(
                'assets/images/app/yoga.json',
                width: 330,
                height: 250,
                repeat: true,
              ),
        
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _status,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: ThemeConfigs.color20,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
        
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: GestureDetector(
                  onTap: _isSpeaking
                      ? () async {
                          await _tts.stop();
                        }
                      : _handleInteraction,
                  child: Container(
                    padding: const EdgeInsets.all(26),
                    decoration: BoxDecoration(
                      color: _isSpeaking
                          ? ThemeConfigs.color31
                          : (_isLoading ? Colors.grey : ThemeConfigs.color3),
                      shape: BoxShape.circle,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          spreadRadius: 2,
                        )
                      ],
                    ),
                    child: Icon(
                      _isSpeaking ? Icons.stop : Icons.mic,
                      size: 56,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
        
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: _clearConversation,
                    icon: const Icon(Icons.delete, color: ThemeConfigs.color31),
                  ),
                ],
              ),
        
              Expanded(
                child: ListView(
                  controller: _scrollController,
                  padding: const EdgeInsets.only(bottom: 10),
                  children: [
                    ..._messages.map(_buildMessageBubble),
                    const SizedBox(height: 10),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
          
              if (_isSpeaking)
                const Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Text(
                    "Tap the button to stop AI voice",
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              else if (_isLoading)
                const Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Text(
                    "Please wait...",
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              else
                const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}