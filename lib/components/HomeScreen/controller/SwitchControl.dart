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
    return  Switch(
                value: widget.device.status,
                onChanged: (value) {
                  setState(() {
                    widget.device.status = value;
                    Device.updateStatusDevice(
                        user, widget.device.room, widget.device.title, value);
                    print(
                        "$user, ${widget.device.room} ${widget.device.title}, $value");
                  });
                });
  }
}