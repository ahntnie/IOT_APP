import 'package:flutter/material.dart';
import 'package:iot_app/components/model/DTO/device.dart';

class ControllerInfo extends StatefulWidget {
  ControllerInfo({super.key, required this.device});
  List<Device> device;
  @override
  State<ControllerInfo> createState() => _ControllerInfoState();
}

class _ControllerInfoState extends State<ControllerInfo> {
  @override
  Widget build(BuildContext context) {
    int count = widget.device.length;
    return Scaffold(
      appBar: AppBar(title: Text("Controll Info")),
      body: ListView.builder(
          itemCount: count,
          itemBuilder: (BuildContext context, int index) {
            return Row(
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  width: MediaQuery.of(context).size.width,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Name Controll: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text("${widget.device[index].NameDevice}")
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Control : ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text("${widget.device[index].title}")
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Room:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text("${widget.device[index].room}")
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Type: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text("${widget.device[index].typeDevice}")
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Status: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(widget.device[index].status ? "ON" : "OFF")
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Origin: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text("Viet Nam")
                        ],
                      )
                    ],
                  ),
                )
              ],
            );
          }),
    );
  }
}
