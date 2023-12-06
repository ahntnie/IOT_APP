import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iot_app/components/model/DTO/device.dart';
import 'package:iot_app/components/model/DTO/room.dart';
class device_detail extends StatefulWidget {
  const device_detail({super.key, required this.device});
  final Device device;
  @override
  State<device_detail> createState() => _device_detailState();
}

class _device_detailState extends State<device_detail> {
  String txtStatus = "";



  @override
  void initState() {
    super.initState();
    setState(() {
      if(widget.device.status){
        txtStatus="ON";
      }
      else if(widget.device.value!=0){
        txtStatus="ON";
      }
      else{
        txtStatus = "OFF";
      }
    });
    
  }

  @override
  Widget build(BuildContext context) {
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
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                        ),
                      ),
                      Text(widget.device.title,style: TextStyle(fontSize: 16))
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
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                        ),
                      ),
                      Text(widget.device.room,style: TextStyle(fontSize: 16),)
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
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                        ),
                      ),
                      Text("$txtStatus",style: TextStyle(fontSize: 16),)
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
                          "Type control: ",
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                        ),
                      ),
                      Text(widget.device.typeDevice,style: TextStyle(fontSize: 16),)
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
