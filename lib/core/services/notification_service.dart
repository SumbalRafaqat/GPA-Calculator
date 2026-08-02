import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;

/// Handles daily reminder local notifications, toggled from Settings.
/// Rotates through a pool of motivational messages so the notification
/// text changes day to day.
class NotificationService {
  NotificationService._internal();
  static final NotificationService instance = NotificationService._internal();

  final FlutterLocalNotificationsPlugin _plugin =
  FlutterLocalNotificationsPlugin();

  static const int _dailyReminderId = 1001;
  static const int _reminderHour = 20; // 8:00 PM
  static const int _reminderMinute = 0;

  static const List<String> _messages = [
    "Don't forget to calculate your GPA today!",
    "Track your progress — check your GPA now 📊",
    "Time for a quick GPA check-in!",
    "Stay on top of your academics — open GPA Planner",
    "Your academic goals are waiting — calculate now!",
  ];

  bool _initialized = false;

  /// Initializes plugin + timezone data. Call once at app startup.
  Future<void> init() async {
    if (_initialized) return;

    tz_data.initializeTimeZones();

    const androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidSettings);

    await _plugin.initialize(initSettings);
    _initialized = true;
  }

  /// Requests the Android 13+ POST_NOTIFICATIONS runtime permission.
  Future<bool> requestPermission() async {
    final androidImpl = _plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    final granted = await androidImpl?.requestNotificationsPermission();
    return granted ?? false;
  }
  /// Picks today's message by rotating through the pool based on the
  /// day of the year, so it changes daily without needing storage.
  String _todayMessage() {
    final dayOfYear = int.parse(
      '${DateTime.now().month}${DateTime.now().day}',
    );
    final index = dayOfYear % _messages.length;
    return _messages[index];
  }

  /// Schedules a repeating daily notification at [_reminderHour]:[_reminderMinute].
  /// Cancels any previous schedule first so re-enabling doesn't duplicate.
  Future<void> scheduleDailyReminder() async {
    await cancelDailyReminder();

    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      _reminderHour,
      _reminderMinute,
    );
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    await _plugin.zonedSchedule(
      _dailyReminderId,
      'GPA Planner',
      _todayMessage(),
      scheduledDate,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_reminder_channel',
          'Daily Reminders',
          channelDescription: 'Daily reminder to check your GPA',
          importance: Importance.defaultImportance,
          priority: Priority.defaultPriority,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time, // repeats daily
    );
  }

  /// Cancels the daily reminder (called when the user toggles it off).
  Future<void> cancelDailyReminder() async {
    await _plugin.cancel(_dailyReminderId);
  }

  /// Shows an immediate test notification — useful to verify permissions
  /// and channel setup are working right away.
  Future<void> showTestNotification() async {
    await _plugin.show(
      9999,
      'GPA Planner',
      _todayMessage(),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_reminder_channel',
          'Daily Reminders',
          channelDescription: 'Daily reminder to check your GPA',
          importance: Importance.defaultImportance,
          priority: Priority.defaultPriority,
        ),
      ),
    );
  }
}