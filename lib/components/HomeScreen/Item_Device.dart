import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iot_app/components/HomeScreen/controller/ButtonControl.dart';
import 'package:iot_app/components/HomeScreen/controller/SliderControl.dart';
import 'package:iot_app/components/HomeScreen/controller/SwitchControl.dart';
import 'package:iot_app/components/model/DTO/device.dart';

class ItemDevice extends StatefulWidget {
  const ItemDevice({super.key, required this.device});
  final Device device;

  @override
  State<ItemDevice> createState() => _ItemDeviceState();
}

class _ItemDeviceState extends State<ItemDevice> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.45,
      height: 140,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
            color: Colors.grey[200],
            child: widget.device.typeDevice == "Congtac"
                ? SwitchControl(device: widget.device)
                : widget.device.typeDevice == "NutNhan"
                    ? ButtonControl(device:widget.device)
                    : SliderControl(device:widget.device)),
      ),
    );
  }
}
