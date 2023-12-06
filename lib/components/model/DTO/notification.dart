import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService{
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final AndroidInitializationSettings androidInitializationSettings = const AndroidInitializationSettings('@mipmap/ic_launcher');


void initNotification() async{
  InitializationSettings initializationSettings = InitializationSettings(
    android: androidInitializationSettings
  );
  _flutterLocalNotificationsPlugin.initialize(
    initializationSettings
  );
}

void sendNotification() async
{
  AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
    "channelId",
    "channelName",
    importance: Importance.max,
    priority: Priority.max
  );
  NotificationDetails notificationDetails = NotificationDetails(
    android: androidNotificationDetails
  );
  await _flutterLocalNotificationsPlugin.show(
    0,
    'iAPP',
    'Good luck my project tomorrow',
    notificationDetails
  );
}
}