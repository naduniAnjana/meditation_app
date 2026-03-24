import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/material.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();

  factory NotificationService() {
    return _instance;
  }

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;

    tz.initializeTimeZones();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );

    _initialized = true;
  }

  Future<void> scheduleBedtimeReminder(
      TimeOfDay bedtime, int reminderMinutesBefore) async {
    await init();
    await cancelBedtimeReminder(); // Cancel any existing bedtime reminders

    final now = DateTime.now();
    var reminderTime = DateTime(
      now.year,
      now.month,
      now.day,
      bedtime.hour,
      bedtime.minute,
    ).subtract(Duration(minutes: reminderMinutesBefore));

    // If the reminder time is in the past, schedule for tomorrow
    if (reminderTime.isBefore(now)) {
      reminderTime = reminderTime.add(const Duration(days: 1));
    }

    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'bedtime_channel',
      'Bedtime Reminders',
      channelDescription: 'Notifications for bedtime reminders',
      importance: Importance.max,
      priority: Priority.high,
    );

    final iOSPlatformChannelSpecifics = DarwinNotificationDetails();

    final platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0, // Notification ID
      'Time to Wind Down 🌙',
      'Prepare for a peaceful sleep.',
      tz.TZDateTime.from(reminderTime, tz.local),
      platformChannelSpecifics,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time, // Repeat daily at same time
    );
  }

  Future<void> cancelBedtimeReminder() async {
    await flutterLocalNotificationsPlugin.cancel(0);
  }

  Future<void> cancelMeditationReminder() async {
    for (int i = 1; i <= 8; i++) {
      await flutterLocalNotificationsPlugin.cancel(i);
    }
  }

  Future<void> scheduleMeditationReminder() async {
    await init();
    await cancelMeditationReminder();

    final messages = [
      'How are you feeling now?',
      'You’re not alone, I’m here for you',
      'If something is worrying you, take a moment to breathe or talk it out.',
    ];

    final androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'meditation_channel',
      'Meditation Reminders',
      channelDescription: 'Notifications for meditation reminders',
      importance: Importance.max,
      priority: Priority.high,
    );

    final iOSPlatformChannelSpecifics = const DarwinNotificationDetails();

    final platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    final now = DateTime.now();

    for (int i = 0; i < 8; i++) {
      int hour = i * 3;
      var reminderTime = DateTime(
        now.year,
        now.month,
        now.day,
        hour,
        0,
      );

      if (reminderTime.isBefore(now)) {
        reminderTime = reminderTime.add(const Duration(days: 1));
      }

      final message = messages[i % messages.length]; // We will just cycle through them to ensure variety

      await flutterLocalNotificationsPlugin.zonedSchedule(
        i + 1, // Notification IDs 1 to 8
        'Meditation Check-in 🧘',
        message,
        tz.TZDateTime.from(reminderTime, tz.local),
        platformChannelSpecifics,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    }
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
