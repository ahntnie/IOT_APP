  import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:iot_app/components/AddDeviceScreen/AddDeviceScreen.dart';
import 'package:iot_app/components/HomeScreen/changePassword.dart';
import 'package:iot_app/components/HomeScreen/notification.dart';
import 'package:iot_app/components/SignIn_SignUp/signin.dart';
import 'package:iot_app/components/SignIn_SignUp/signup.dart';
import 'package:iot_app/components/mainApp.dart';
import 'package:iot_app/components/model/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iAPP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/home': (context) => const MainApp(),
        '/add-device': (context) => const AddDeviceScreen(),
        '/notification': (context) => const NotificationView(),
        '/change-password': (context) => const ChangePassword(),
        '/signup': (context) => const SignUp(),
        '/signin': (context) => const SignIn()
      },
      home: const SignIn(),
    );
  }
}
