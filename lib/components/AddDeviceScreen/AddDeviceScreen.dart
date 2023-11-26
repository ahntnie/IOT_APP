import 'package:flutter/material.dart';
import 'package:iot_app/components/HomeScreen/device.dart';

class AddDeviceScreen extends StatefulWidget {
  const AddDeviceScreen({super.key});

  @override
  State<AddDeviceScreen> createState() => _AddDeviceScreenState();
}

class _AddDeviceScreenState extends State<AddDeviceScreen> {
  TextEditingController title = TextEditingController();
  TextEditingController room = TextEditingController();
  String titleValue = "";
  String roomValue = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Device',style: TextStyle(
          color: Colors.grey.shade400,
          fontSize: 25,
          fontWeight: FontWeight.w500
        ),),
        centerTitle: true,
        leading: IconButton(
          onPressed: (){Navigator.pop(context);},
          icon: Icon(Icons.arrow_back,color: Colors.grey[400],),
      ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(5,10,5,10),
              child: TextField(
                controller: title,
                decoration: const InputDecoration(
                  hintText: "Device's name"
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(5,10,5,10),
              child: TextField(
                controller: room,
                decoration: const InputDecoration(
                  hintText: "Room"
                ),
              ),
            ),
            ElevatedButton(onPressed: (){
              setState(() {
                titleValue = title.text;
                roomValue = room.text;
              });
              Device.addNewDevice(Device("https://cdn-icons-png.flaticon.com/512/6134/6134812.png",titleValue,roomValue,false));
            },
              child: const Text("Add")
            ),
          ],
        ),
      ),
    );
  }
}