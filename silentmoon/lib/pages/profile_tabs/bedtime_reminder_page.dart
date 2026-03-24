import 'package:flutter/material.dart';
import 'package:silentmoon/app/configs/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:silentmoon/services/notification_service.dart';

class BedtimeReminderPage extends StatefulWidget {
  const BedtimeReminderPage({super.key});

  @override
  State<BedtimeReminderPage> createState() => _BedtimeReminderPageState();
}

class _BedtimeReminderPageState extends State<BedtimeReminderPage> {
  bool _isEnabled = false;
  TimeOfDay _bedtime = const TimeOfDay(hour: 22, minute: 0);
  int _reminderMinutes = 10;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isEnabled = prefs.getBool('isBedtimeReminderEnabled') ?? false;
      int hour = prefs.getInt('bedtimeHour') ?? 22;
      int minute = prefs.getInt('bedtimeMinute') ?? 0;
      _bedtime = TimeOfDay(hour: hour, minute: minute);
      _reminderMinutes = prefs.getInt('reminderMinutesBefore') ?? 10;
    });
  }

  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isBedtimeReminderEnabled', _isEnabled);
    await prefs.setInt('bedtimeHour', _bedtime.hour);
    await prefs.setInt('bedtimeMinute', _bedtime.minute);
    await prefs.setInt('reminderMinutesBefore', _reminderMinutes);

    final notificationService = NotificationService();

    if (_isEnabled) {
      await notificationService.scheduleBedtimeReminder(
          _bedtime, _reminderMinutes);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Bedtime reminder scheduled!')),
        );
      }
    } else {
      await notificationService.cancelBedtimeReminder();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Bedtime reminder disabled.')),
        );
      }
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _bedtime,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: ThemeConfigs.color27,
              onSurface: ThemeConfigs.color4,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _bedtime) {
      setState(() {
        _bedtime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeConfigs.color26,
      appBar: AppBar(
        title: const Text('Bedtime Reminders', style: TextStyle(color: ThemeConfigs.color19)),
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

              if (_isEnabled) ...[
                // Time Picker
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    title: const Text(
                      'Bedtime',
                      style: TextStyle(
                        color: ThemeConfigs.color4,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    trailing: Text(
                      _bedtime.format(context),
                      style: const TextStyle(
                        color: ThemeConfigs.color27,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () => _selectTime(context),
                  ),
                ),
                const SizedBox(height: 20),

                // Interval Dropdown
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Remind me before',
                        style: TextStyle(
                          color: ThemeConfigs.color4,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      DropdownButton<int>(
                        value: _reminderMinutes,
                        underline: const SizedBox(),
                        icon: const Icon(Icons.arrow_drop_down, color: ThemeConfigs.color27),
                        style: const TextStyle(
                          color: ThemeConfigs.color27,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        items: const [
                          DropdownMenuItem(value: 10, child: Text('10 mins')),
                          DropdownMenuItem(value: 30, child: Text('30 mins')),
                          DropdownMenuItem(value: 60, child: Text('60 mins')),
                        ],
                        onChanged: (int? newValue) {
                          if (newValue != null) {
                            setState(() {
                              _reminderMinutes = newValue;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],

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
