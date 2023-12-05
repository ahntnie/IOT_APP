import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iot_app/components/model/DTO/device.dart';

class ButtonControl extends StatefulWidget {
  const ButtonControl({super.key,required this.device});
  final Device device;
  @override
  State<ButtonControl> createState() => _ButtonControlState();
}

class _ButtonControlState extends State<ButtonControl> {
   String? user = FirebaseAuth.instance.currentUser!.displayName;
   int button=0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(
          "https://cdn-icons-png.flaticon.com/512/6134/6134812.png",
          fit: BoxFit.cover,
          width: 50,
          height: 50,
        ),
        Text(
          widget.device.title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
        Stack(children: [
          IconButton(
              onPressed: () {
                setState(() {
                  button = button + 1;
                  if (button == 4) {
                    button = 0;
                  }
                   Device.updateValueDevice(user, widget.device.room, widget.device.title,button);
                    print("$user, ${widget.device.room} ${widget.device.title},value:$button");
                  print("Button's value: $button");
                });
              },
              icon: Icon(Icons.panorama_fish_eye_sharp),
              iconSize: 36),
          Positioned(top: 0, right: 0, child: Text("$button")),
        ]),
      ],
    );
  }
}