import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iot_app/components/model/DTO/device.dart';

class ItemDevice extends StatefulWidget {
  const ItemDevice({super.key, required this.device});
  final Device device;

  @override
  State<ItemDevice> createState() => _ItemDeviceState();
}

class _ItemDeviceState extends State<ItemDevice> {
  var nutnhan = 0;
  ItemSlider(Device device) {
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
        Slider(
          value: device.value.toDouble(),
          min: 0.0,
          max: 100.0,
          onChanged: (value) {
            setState(() {
              widget.device.value = value.toInt();
              Device.updateValueDevice(
                  user, device.room, device.title, widget.device.value);
            });
          },
        ),
      ],
    );
  }

  Congtac(Device device) {
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

  NutNhan(Device device) {
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
                  nutnhan = nutnhan + 1;
                  if (nutnhan == 5) {
                    nutnhan = 0;
                  }
                  print(nutnhan);
                });
              },
              icon: Icon(Icons.panorama_fish_eye_sharp),
              iconSize: 36),
          Positioned(top: 0, right: 0, child: Text("$nutnhan")),
        ]),
      ],
    );
  }

  String? user = FirebaseAuth.instance.currentUser!.displayName;
  bool status = false;

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
                ? Congtac(widget.device)
                : widget.device.typeDevice == "NutNhan"
                    ? NutNhan(widget.device)
                    : ItemSlider(widget.device)),
      ),
    );
  }
}
