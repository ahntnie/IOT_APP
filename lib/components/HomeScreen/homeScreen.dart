import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:iot_app/components/HomeScreen/Item_Device.dart';
import 'package:iot_app/components/HomeScreen/buttonOption.dart';
import 'package:iot_app/components/SignIn_SignUp/signup.dart';
import 'package:iot_app/components/model/DTO/device.dart';
import 'package:iot_app/components/HomeScreen/welcome.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Device> _devices =
      List.filled(0, Device("", "", "", false), growable: true);
  void _loadData() {
    Device.loadData().then((value) {
      setState(() {
        _devices = Device.devices;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    Device.devices.clear();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    // DatabaseReference ref = FirebaseDatabase.instance.ref("users");

    String updateName() {
      String user = "null";

      // Lấy thông tin người dùng đang đăng nhập
      User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        // Lấy displayName từ thông tin người dùng
        String? username = currentUser.displayName;

        if (username != null && username.isNotEmpty) {
          user = username;
        } else {
          user = "null";
        }
      }

      return user;
    }

    int count = (_devices.length / 2).ceil();
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Welcome(name: updateName()),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Rooms",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: AlwaysScrollableScrollPhysics(),
              child: Row(
                children: [
                  ButtonOption(
                    roomName: "Home",
                    onPressed: () {
                      setState(() {
                        _devices = Device.getListDevice();
                      });
                    },
                  ),
                  ButtonOption(
                      roomName: "Living room",
                      onPressed: () {
                        setState(() {
                          _devices = Device.getListDeviceByRoom("Living room");
                        });
                      }),
                  ButtonOption(
                      roomName: "Bedroom",
                      onPressed: () {
                        setState(() {
                          _devices = Device.getListDeviceByRoom("Bedroom");
                        });
                      }),
                  ButtonOption(
                      roomName: "Kitchen",
                      onPressed: () {
                        setState(() {
                          _devices = Device.getListDeviceByRoom("Kitchen");
                        });
                      }),
                  ButtonOption(
                      roomName: "Resroom",
                      onPressed: () {
                        setState(() {
                          _devices = Device.getListDeviceByRoom("Resroom");
                        });
                      }),
                  ButtonOption(
                    roomName: "",
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text(
                                "Add new room",
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.w600),
                              ),
                              content: TextField(
                                decoration: InputDecoration(
                                    hintText: "Enter new room's name"),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Cancel")),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("OK"))
                              ],
                            );
                          });
                    },
                    icon: Icons.add,
                  )
                ],
              )),
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
