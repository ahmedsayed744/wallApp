import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:spendwise/feature/remember_me/model/task_model.dart';
import 'package:spendwise/generated/l10n.dart';
import 'package:spendwise/core/routing/navigator_key.dart';
import 'package:spendwise/core/routing/routs.dart';
import 'dart:developer' as dev;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    tz_data.initializeTimeZones();
    try {
      final timezoneInfo = await FlutterTimezone.getLocalTimezone();
      final String timeZoneName = timezoneInfo.identifier;
      tz.setLocalLocation(tz.getLocation(timeZoneName));
      dev.log("Timezone initialized: $timeZoneName");
    } catch (e) {
      dev.log("Error initializing timezone: $e");
      // Fallback if precision fails
      tz.setLocalLocation(tz.getLocation('UTC'));
    }

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );

    const InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS,
        );

    await _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse details) {
        if (details.payload != null) {
          _handleNotificationTap(details.payload!);
        }
      },
    );

    // Request permissions for Android 13+
    await requestPermissions();

    // Check if app was launched via notification tap
    final launchDetails = await _notificationsPlugin
        .getNotificationAppLaunchDetails();
    if (launchDetails?.didNotificationLaunchApp ?? false) {
      final payload = launchDetails?.notificationResponse?.payload;
      if (payload != null) {
        // App needs a small delay to ensure navigator is ready
        Future.delayed(
          const Duration(seconds: 1),
          () => _handleNotificationTap(payload),
        );
      }
    }
  }

  static void _handleNotificationTap(String payload) {
    dev.log("Notification tapped with payload: $payload");
    // Navigate to Remember Me screen
    navigatorKey.currentState?.pushNamed(Routs.rememberMeView);
  }

  /// Explicitly request permissions from the user
  static Future<bool> requestPermissions() async {
    final androidImplementation = _notificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    if (androidImplementation != null) {
      final bool? granted = await androidImplementation.requestNotificationsPermission();
      dev.log("Android notification permission: $granted");

      // Request exact alarm permission for Android 12+ (required for exactAllowWhileIdle)
      final bool? exactGranted = await androidImplementation.requestExactAlarmsPermission();
      dev.log("Android exact alarm permission: $exactGranted");
    }

    final iosImplementation = _notificationsPlugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >();

    final iosGranted = await iosImplementation?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
    dev.log("iOS notification permission: $iosGranted");

    return true; // We return true to not block app flow, but log the result
  }

  static Future<void> scheduleTaskNotification(TaskModel task) async {
    final scheduledDate = DateTime(
      task.date.year,
      task.date.month,
      task.date.day,
      task.time.hour,
      task.time.minute,
    );

    // Convert to TZDateTime
    tz.TZDateTime tzScheduledDate = tz.TZDateTime.from(scheduledDate, tz.local);

    // If it's in the past, handle it
    if (tzScheduledDate.isBefore(tz.TZDateTime.now(tz.local))) {
      if (task.repeat == TaskRepeat.none) {
        dev.log("Task is in the past and no repeat: not scheduling.");
        return;
      } else {
        // For repeating tasks, zonedSchedule with matchDateTimeComponents
        // usually handles the next occurrence, but let's be explicit if needed.
        dev.log("Task is in the past but repeating: scheduling for next occurrence.");
      }
    }

    dev.log("Scheduling notification for: $tzScheduledDate");

    DateTimeComponents? matchComponents;
    if (task.repeat == TaskRepeat.daily) {
      matchComponents = DateTimeComponents.time;
    } else if (task.repeat == TaskRepeat.weekly) {
      matchComponents = DateTimeComponents.dayOfWeekAndTime;
    }

    await _notificationsPlugin.zonedSchedule(
      task.id.hashCode,
      task.title,
      task.description ?? S.current.rememberMe,
      tzScheduledDate,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'reminder_channel',
          'Reminders',
          channelDescription: 'High priority notifications for task reminders',
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
         
          // sound: const RawResourceAndroidNotificationSound('alarm'),
          enableVibration: true,
          fullScreenIntent: true,
        ),
        iOS: const DarwinNotificationDetails(

          // sound: 'alarm.mp3',
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: matchComponents,
      payload: task.id,
    );
  }

  static Future<void> cancelNotification(String taskId) async {
    await _notificationsPlugin.cancel(taskId.hashCode);
  }

}
