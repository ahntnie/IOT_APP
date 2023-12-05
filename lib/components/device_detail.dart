import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iot_app/components/model/DTO/device.dart';
import 'package:iot_app/components/model/DTO/room.dart';

class device_detail extends StatefulWidget {
  device_detail({super.key, required this.device});
  Device device;
  @override
  State<device_detail> createState() => _device_detailState();
}

class _device_detailState extends State<device_detail> {
  String? selectedItemRoom;
  String? user = FirebaseAuth.instance.currentUser!.displayName;
  var TextDevice = TextEditingController();

  List<String> room = [];
  void _loadRoom() {
    Room.getListRoom(user).then((value) {
      setState(() {
        room = Room.listRoom;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    TextDevice.text = widget.device.title;
    Room.listRoom.clear();
    _loadRoom();
  }

  @override
  Widget build(BuildContext context) {
    var selectedValue;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'DEVICE DETAIL',
            style: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 25,
                fontWeight: FontWeight.w500),
          ),
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 100.0,
                  backgroundImage: NetworkImage(
                      'https://cdn-icons-png.flaticon.com/512/6134/6134812.png'),
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 30, 0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Text(
                          "Device's name: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(widget.device.title)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Text(
                          "Room Name: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(widget.device.room)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Text(
                          "Status: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text("${widget.device.status}")
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Text(
                          "Typle control: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(widget.device.typeDevice)
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ));
  }
}
