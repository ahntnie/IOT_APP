import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iot_app/components/HomeScreen/Item_Device.dart';
import 'package:iot_app/components/HomeScreen/buttonOption.dart';
import 'package:iot_app/components/model/DTO/device.dart';
import 'package:iot_app/components/HomeScreen/welcome.dart';
import 'package:iot_app/components/model/DTO/room.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? user = FirebaseAuth.instance.currentUser!.displayName;
  List<Device> _devices =
      List.filled(0, Device("", "", "", false), growable: true);
  List room = [];
  void _loadData() {
    Device.loadData().then((value) {
      setState(() {
        _devices = Device.devices;
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
    Device.devices.clear();
    _loadData();
    Room.listRoom.clear();
    _loadRoom();
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
                        edit = true;
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
                if (edit) {
                  Future.delayed(Duration(seconds: 1), () {
                    Navigator.pop(context);
                    setState(() {
                      Room.listRoom.clear();
                      _loadRoom();
                    });
                  });
                } else {
                  Navigator.pop(context);
                }
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
                Navigator.pop(context);
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // DatabaseReference ref = FirebaseDatabase.instance.ref("users");

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
          const Text(
            "Rooms",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          // SingleChildScrollView(
          //     scrollDirection: Axis.horizontal,
          //     physics: AlwaysScrollableScrollPhysics(),

          // child: Row(
          //   children: [
          //         ButtonOption(
          //           roomName: "Home",
          //           onPressed: () {
          //             setState(() {
          //               _devices = Device.getListDevice();
          //             });
          //           },
          //         ),
          //         ButtonOption(
          //             roomName: "Living room",
          //             onPressed: () {
          //               setState(() {
          //                 _devices = Device.getListDeviceByRoom("Living room");
          //               });
          //             }),
          //         ButtonOption(
          //             roomName: "Bedroom",
          //             onPressed: () {
          //               setState(() {
          //                 _devices = Device.getListDeviceByRoom("Bedroom");
          //               });
          //             }),
          //         ButtonOption(
          //             roomName: "Kitchen",
          //             onPressed: () {
          //               setState(() {
          //                 _devices = Device.getListDeviceByRoom("Kitchen");
          //               });
          //             }),
          //         ButtonOption(
          //             roomName: "Resroom",
          //             onPressed: () {
          //               setState(() {
          //                 _devices = Device.getListDeviceByRoom("Resroom");
          //               });
          //             }),
          //     ButtonOption(
          //       roomName: "",
          //       onPressed: () {
          //         showDialog(
          //             context: context,
          //             builder: (BuildContext context) {
          //               return AlertDialog(
          //                 title: const Text(
          //                   "Add new room",
          //                   style: TextStyle(
          //                       fontSize: 25, fontWeight: FontWeight.w600),
          //                 ),
          //                 content: TextField(
          //                   decoration: InputDecoration(
          //                       hintText: "Enter new room's name"),
          //                 ),
          //                 actions: [
          //                   TextButton(
          //                       onPressed: () {
          //                         Navigator.pop(context);
          //                       },
          //                       child: Text("Cancel")),
          //                   TextButton(
          //                       onPressed: () {
          //                         Navigator.pop(context);
          //                       },
          //                       child: Text("OK"))
          //                 ],
          //               );
          //             });
          //       },
          //       icon: Icons.add,
          //     )
          //   ],
          // )),

          Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            child: ListView.builder(
                primary: false,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: countRoom,
                itemBuilder: (BuildContext context, int index) {
                  return index == countRoom - 1
                      ? ButtonOption(
                          roomName: "",
                          onPressed: showAddRoomDialog,
                          icon: Icons.add,
                        )
                      : ButtonOption(
                          roomName: room[index].toString(),
                          onPressed: () {
                            setState(() {
                              // _devices = Device.getListDeviceByRoom("Kitchen");
                            });
                          },
                          onLongPressed: () {
                            _showOptionsDialog(room[index].toString());
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
}
