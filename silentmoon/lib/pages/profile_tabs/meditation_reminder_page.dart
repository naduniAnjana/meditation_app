import 'package:flutter/material.dart';
import 'package:silentmoon/app/configs/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:silentmoon/services/notification_service.dart';

class MeditationReminderPage extends StatefulWidget {
  const MeditationReminderPage({super.key});

  @override
  State<MeditationReminderPage> createState() => _MeditationReminderPageState();
}

class _MeditationReminderPageState extends State<MeditationReminderPage> {
  bool _isEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isEnabled = prefs.getBool('isMeditationReminderEnabled') ?? false;
    });
  }

  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isMeditationReminderEnabled', _isEnabled);

    final notificationService = NotificationService();

    if (_isEnabled) {
      await notificationService.scheduleMeditationReminder();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Meditation reminder scheduled!')),
        );
      }
    } else {
      await notificationService.cancelMeditationReminder();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Meditation reminder disabled.')),
        );
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeConfigs.color26,
      appBar: AppBar(
        title: const Text('Meditation Reminders', style: TextStyle(color: ThemeConfigs.color19)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: ThemeConfigs.color19),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Reminder Toggle
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Enable Reminder',
                      style: TextStyle(
                        color: ThemeConfigs.color4,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Switch(
                      value: _isEnabled,
                      activeColor: ThemeConfigs.color27,
                      onChanged: (value) {
                        setState(() {
                          _isEnabled = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),



              const Spacer(),

              // Save Button
              GestureDetector(
                onTap: () {
                  _savePreferences();
                },
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: ThemeConfigs.color27,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Center(
                    child: Text(
                      'SAVE',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
