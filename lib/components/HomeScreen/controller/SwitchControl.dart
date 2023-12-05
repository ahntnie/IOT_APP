import 'package:flutter/material.dart';
import 'package:iot_app/components/model/DTO/device.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SwitchControl extends StatefulWidget {
  const SwitchControl({super.key,required this.device});
  final Device device;
  @override
  State<SwitchControl> createState() => _SwitchControlState();
}

class _SwitchControlState extends State<SwitchControl> {
  String? user = FirebaseAuth.instance.currentUser!.displayName;

  @override
  Widget build(BuildContext context) {
    return  Column(
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              widget.device.status ? "ON" : "OFF",
              style: TextStyle(
                  color: widget.device.status ? Colors.green : Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            Switch(
                value: widget.device.status,
                onChanged: (value) {
                  setState(() {
                    widget.device.status = value;
                    Device.updateStatusDevice(
                        user, widget.device.room, widget.device.title, value);
                    print(
                        "$user, ${widget.device.room} ${widget.device.title}, $value");
                  });
                })
          ],
        )
      ],
    );
  }
}