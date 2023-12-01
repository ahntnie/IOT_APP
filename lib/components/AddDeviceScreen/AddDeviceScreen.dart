import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:iot_app/components/HomeScreen/homeScreen.dart';
import 'package:iot_app/components/model/DTO/device.dart';
import 'package:iot_app/components/model/DTO/room.dart';

class AddDeviceScreen extends StatefulWidget {
  const AddDeviceScreen({super.key});

  @override
  State<AddDeviceScreen> createState() => _AddDeviceScreenState();
}

class _AddDeviceScreenState extends State<AddDeviceScreen> {
  List<String> typeDevice = [];
  List<String> rooms = [];
  String? selectedItem;
  String? selectedItemRoom;
  String? user = FirebaseAuth.instance.currentUser!.displayName;
  TextEditingController title = TextEditingController();

  void LoadTypeDevice() async {
    final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    var snapshot = await databaseReference.child('''
TypeDevice''').get();
    for (final room in snapshot.children) {
      typeDevice.add(room.value.toString());
    }
    selectedItem = typeDevice[0];
  }

  void _loadRoom() {
    Room.getListRoom(user).then((value) {
      setState(() {
        rooms = Room.listRoom;
        selectedItemRoom = rooms[0];
      });
    });
  }

  @override
  void initState() {
    super.initState();
    LoadTypeDevice();
    Room.listRoom.clear();
    _loadRoom();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Device',
          style: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 25,
              fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/home');
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.grey[400],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                child: TextField(
                  controller: title,
                  decoration: const InputDecoration(hintText: "Device's name"),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 10, 20, 10),
                    child: Text("Room Name: "),
                  ),
                  Expanded(
                    flex: 1,
                    child: DropdownButton<String>(
                      value: selectedItemRoom,
                      items: rooms.map((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedItemRoom = newValue;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 10, 20, 10),
                    child: Text("Type Device: "),
                  ),
                  Expanded(
                    child: DropdownButton<String>(
                      value: selectedItem,
                      items: typeDevice.map((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedItem = newValue;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: SizedBox(
                  width: 150,
                  child: ElevatedButton(
                      onPressed: () {
                        Device.addDevice(
                            user, selectedItemRoom, title.text, selectedItem);
                        Navigator.popAndPushNamed(context, '/home');
                      },
                      child: const Text("Add")),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
