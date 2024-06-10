import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static NotificationService helper = NotificationService._();

  NotificationService._();

  FlutterLocalNotificationsPlugin localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(
        tz.getLocation(await FlutterTimezone.getLocalTimezone()));
    AndroidInitializationSettings initAndroid =
        const AndroidInitializationSettings('logo');
    DarwinInitializationSettings initIos = const DarwinInitializationSettings();
    InitializationSettings initSetting =
        InitializationSettings(android: initAndroid, iOS: initIos);
    await localNotificationsPlugin.initialize(initSetting);
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestExactAlarmsPermission();
  }

  Future<void> showNotification(String title, String body) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      "1",
      "hello",
      priority: Priority.high,
      importance: Importance.max,
      styleInformation:
          BigPictureStyleInformation(DrawableResourceAndroidBitmap('logo')),
    );
    DarwinNotificationDetails iosNotificationDetails =
        const DarwinNotificationDetails();
    NotificationDetails details = NotificationDetails(
        iOS: iosNotificationDetails, android: androidNotificationDetails);

    await localNotificationsPlugin.show(1, "hello", "how are you", details);
  }

  Future<void> scheduleNotification() async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails("1", "hello",
            priority: Priority.high,
            importance: Importance.max,
            styleInformation: BigPictureStyleInformation(
                DrawableResourceAndroidBitmap('logo')));
    DarwinNotificationDetails iosNotificationDetails =
        const DarwinNotificationDetails();
    NotificationDetails details = NotificationDetails(
        iOS: iosNotificationDetails, android: androidNotificationDetails);

    await localNotificationsPlugin.zonedSchedule(1, "hii", "hello",
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)), details,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }
}
