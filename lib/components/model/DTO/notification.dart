// import'package:firebase_messaging/firebase_messaging.dart';
// import 'package:iot_app/main.dart';
// class NotificationApi{
//   final message = FirebaseMessaging.instance;

//   Future<void> initNotification() async{
//     await message.requestPermission();
//     final fCMToken = await message.getToken();
//     print('Token: $fCMToken');
//     initPushNotification();
//   }

//   void handleMessage(RemoteMessage? message){
//       if(message == null) return;
//       navigatorKey.currentState?.pushNamed('/notification',arguments: message);
//   }

//   Future initPushNotification() async{
//     FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
//     FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
//   }
// }