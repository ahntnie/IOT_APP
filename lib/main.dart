import 'package:flutter/material.dart';
import 'package:iot_app/components/AddDeviceScreen/AddDeviceScreen.dart';
import 'package:iot_app/components/HomeScreen/notification.dart';
import 'package:iot_app/components/mainApp.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IoT App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/home':(context)=>const MainApp(),
        '/add-device':(context)=> const AddDeviceScreen(),
        '/notification':(context)=> const NotificationView(),
      },
      home: const MainApp(),
    );
  }
}

