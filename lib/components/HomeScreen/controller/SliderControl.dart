import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iot_app/components/device_detail.dart';
import 'package:iot_app/components/model/DTO/device.dart';

class SliderControl extends StatefulWidget {
  const SliderControl({super.key, required this.device});
  final Device device;
  @override
  State<SliderControl> createState() => _SliderControlState();
}

class _SliderControlState extends State<SliderControl> {
  String? user = FirebaseAuth.instance.currentUser!.displayName;
  @override
  Widget build(BuildContext context) {
    return Stack(alignment: AlignmentDirectional.center, children: [
      Positioned(
        top: 0,
        right: 0,
        child: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          device_detail(device: widget.device)));
            },
            icon: Icon(
              Icons.info_outline,
            )),
      ),
      Column(
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
          Slider(
              value: widget.device.value.toDouble(),
              min: 0.0,
              max: 255.0,
              onChanged: (double val) {
                setState(() {
                  widget.device.value = val.toInt();
                  Device.updateValueDevice(user, widget.device.room,
                      widget.device.title, val.toInt());
                  print(
                      "$user, ${widget.device.room} ${widget.device.title},${val.toInt()}");
                  print("Button's value: $val");
                });
              })
        ],
      )
    ]);
  }
}
