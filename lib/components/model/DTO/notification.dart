import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationApi{
  FirebaseMessaging _fcm =FirebaseMessaging.instance;

    Future<void> init() async{
      final token = await _fcm.getToken();
      print("TOKEN: $token");
    }

    Future<void> requestPermission() async{
      NotificationSettings settings = await _fcm.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true
      );

      if (settings.authorizationStatus==AuthorizationStatus.authorized) {
        print("User granted permission");
      }
      else if(settings.authorizationStatus==AuthorizationStatus.provisional){
          print("User  granted  provisional permission");
      }
      else {
        print("User declined or has not accepted permission");
      }
      
  }

  Future<void> saveToken(String token) async{
    await FirebaseFirestore.instance.collection("UserTokens").doc("User2").set({
      'token' : token,
    });
  }
}