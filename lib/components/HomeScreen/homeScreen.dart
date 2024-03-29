import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:iot_app/components/HomeScreen/Item_Device.dart';

import 'package:iot_app/components/HomeScreen/buttonOption.dart';
import 'package:iot_app/components/HomeScreen/controllerInfo.dart';

import 'package:iot_app/components/HomeScreen/welcome.dart';
import 'package:iot_app/components/model/DTO/device.dart';
import 'package:iot_app/components/model/DTO/room.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? user = FirebaseAuth.instance.currentUser!.displayName;
  String lcd = "";
  String country = "";
  List<Device> _devices =
      List.filled(0, Device("", "", false, "", 0, ""), growable: true);
  List room = [];
  void _loadData() {
    Device.getListDevice(user).then((value) {
      setState(() {
        _devices = Device.device;
      });
    });
  }

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

    Device.device.clear();
    _loadData();
    Room.listRoom.clear();
    _loadRoom();
  }

  @override
  Widget build(BuildContext context) {
    getLCDInfo();
    int countRoom = room.length + 1;
    int count = (_devices.length / 2).ceil();
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Welcome(name: user),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("LCD Information"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Name: LCD"),
                          Text("Type Screen"),
                          Text("Size 16x2"),
                          Text("Made in China")
                        ],
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Cancel"))
                      ],
                    );
                  });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "LCD Info",
                  style: TextStyle(fontSize: 20),
                ),
                Icon(Icons.arrow_forward_ios_outlined)
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ControllerInfo(device: _devices)));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Controll Info",
                  style: TextStyle(fontSize: 20),
                ),
                Icon(Icons.arrow_forward_ios_outlined)
              ],
            ),
          ),
          Container(
            color: Colors.green[200],
            width: MediaQuery.of(context).size.width - 1,
            height: 190,
            child: Center(
              child: Text(
                lcd,
                style: TextStyle(fontSize: 28),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            "Rooms",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            child: ListView.builder(
                primary: false,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: countRoom + 1,
                itemBuilder: (BuildContext context, int index) {
                  return index == 0
                      ? ButtonOption(
                          roomName: "Home",
                          onPressed: () {
                            Device.device.clear();
                            Device.getListDevice(user).then((value) {
                              setState(() {
                                _devices = Device.device;
                              });
                            });
                          },
                        )
                      : index == countRoom
                          ? ButtonOption(
                              roomName: "",
                              onPressed: showAddRoomDialog,
                              icon: Icons.add,
                            )
                          : ButtonOption(
                              roomName: room[index - 1].toString(),
                              onPressed: () {
                                Device.device.clear();
                                Device.getListDevicebyRoom(
                                        user, room[index - 1].toString())
                                    .then((value) {
                                  setState(() {
                                    _devices = Device.device;
                                  });
                                });
                              },
                              onLongPressed: () {
                                _showOptionsDialog(room[index - 1].toString());
                              },
                            );
                }),
          ),
          const Text(
            "Devices",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Container(
            padding: const EdgeInsets.only(left: 12),
            child: ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: count,
                itemBuilder: (BuildContext context, int index) {
                  if (_devices.length % 2 != 0 && index == count - 1) {
                    return Row(
                      children: [
                        Container(
                            margin: const EdgeInsets.fromLTRB(5, 5, 0, 5),
                            child: ItemDevice(device: _devices[index * 2]))
                      ],
                    );
                  } else {
                    return Row(
                      children: [
                        Container(
                            margin: const EdgeInsets.fromLTRB(5, 5, 0, 5),
                            child: ItemDevice(device: _devices[index * 2])),
                        Container(
                            margin: const EdgeInsets.fromLTRB(5, 5, 0, 5),
                            child: ItemDevice(device: _devices[index * 2 + 1]))
                      ],
                    );
                  }
                }),
          ),
        ],
      ),
    ));
  }

  Future<void> getLCDInfo() async {
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    var snapshot = databaseReference.child('/LCD/').get();
    await snapshot.then((DataSnapshot data) {
      setState(() {
        lcd = data.child('title').value.toString();
        country = data.child('country').value.toString();
      });
    });
    print("LCD title: ");
    print(lcd.isEmpty ? "No data" : lcd);
    print("LCD is made in:");
    print(country.isEmpty ? "No data" : country);
  }

  void showAddRoomDialog() {
    var newRoom = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Add new room",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
          ),
          content: TextField(
            controller: newRoom,
            decoration: InputDecoration(hintText: "Enter new room's name"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Room.addRoom(newRoom.text, user);
                Navigator.pop(context, true);
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    ).then((value) {
      if (value == true) {
        setState(() {
          Room.listRoom.clear();
          _loadRoom();
        });
      }
    });
  }

  void _showOptionsDialog(String index) {
    var edit = false;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit or Delete room"),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                child: Text("Select Edit or Delete"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 130,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        showALert(index);
                      },
                      child: Text("Edit"),
                    ),
                  ),
                  Container(
                    width: 100,
                    child: TextButton(
                      onPressed: () {
                        Room.DeleteRoom(index, user);
                        Navigator.pop(context);
                        setState(() {
                          Room.listRoom.clear();
                          _loadRoom();
                        });
                      },
                      child: Text("Delete"),
                    ),
                  )
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  void showALert(String room) {
    var textroom = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit room"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                  child: TextField(
                    controller: textroom,
                    decoration: InputDecoration(label: Text("NameRoom")),
                  )),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Room.EditRoom(room, textroom.text, user);
                Future.delayed(Duration(seconds: 1), () {
                  Navigator.pop(context);
                  setState(() {
                    Room.listRoom.clear();
                    _loadRoom();
                  });
                });
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
