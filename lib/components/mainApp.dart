import 'package:flutter/material.dart';
import 'package:iot_app/components/HomeScreen/homeScreen.dart';
import 'package:iot_app/components/HomeScreen/profile.dart';
import 'package:iot_app/components/model/DTO/controller.dart';
import 'package:iot_app/components/model/DTO/device.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});
  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "HOME",
          style: TextStyle(
              color: Colors.grey[400],
              fontSize: 25,
              fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/notification');
              },
              icon: Icon(
                Icons.notifications,
                color: Colors.grey[400],
              ))
        ],
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(Icons.menu),
            color: Colors.grey[400],
          );
        }),
      ),
      drawer: Menu(),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(side: BorderSide.none),
        onPressed: () {
          Navigator.pushNamed(context, '/add-device');
        },
        tooltip: "Add a new device",
        child: const Icon(
          Icons.add,
        ),
      ),
      body: const HomeScreen(),
    );
  }
}
