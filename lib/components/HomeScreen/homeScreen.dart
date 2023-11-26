import 'package:flutter/material.dart';
import 'package:iot_app/components/HomeScreen/Item_Device.dart';
import 'package:iot_app/components/HomeScreen/buttonOption.dart';
import 'package:iot_app/components/HomeScreen/device.dart';
import 'package:iot_app/components/HomeScreen/welcome.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Device> _devices = List.filled(0,Device("","","",false),growable: true);
  void _loadData(){
    Device.loadData().then((value){
      setState(() {
        _devices = Device.devices;
      });
    });
  }

  @override void initState(){
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    int count = (_devices.length/2).ceil();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10,),
            const Welcome(name: "Charlie Puth",),
            const SizedBox(height: 10,),
            const Text("Rooms",style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold
            ),),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: AlwaysScrollableScrollPhysics(),
              child: Row(
                children:[
                  ButtonOption(roomName: "Home",onPressed: (){
                    setState(() {
                      _devices = Device.getListDevice();
                     
                    });
                  },),
                  ButtonOption(roomName: "Living room",
                    onPressed: (){
                    setState(() {
                      _devices = Device.getListDeviceByRoom("Living room");
                    });
                    }),
                  ButtonOption(roomName: "Bedroom",
                    onPressed: (){
                    setState(() {
                      _devices = Device.getListDeviceByRoom("Bedroom");
                       
                    });
                  }),
                  ButtonOption(roomName: "Kitchen",
                  onPressed: (){
                    setState(() {
                      _devices = Device.getListDeviceByRoom("Kitchen");
                       
                    });
                  
                  }),
                  ButtonOption(roomName: "Resroom",
                  onPressed: (){
                    setState(() {
                      _devices = Device.getListDeviceByRoom("Resroom");
                    });
                  }),
                  ButtonOption(roomName: "", onPressed:(){},icon: Icons.add,)
                ],
              ),
            ),
            const Text("Devices",style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold
            ),),
            ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: count,
              itemBuilder: (BuildContext context, int index){
                if(_devices.length%2!=0 && index == count-1){
                  return Row(children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(5,5,0,5),
                    child: ItemDevice(device: _devices[index*2])
                    )
                  ],);
                }
                else{
                  return Row(
                    children: [
                      Container(
                      margin: const EdgeInsets.fromLTRB(5,5,0,5),
                      child: ItemDevice(device: _devices[index*2])
                      ),
                      Container(
                      margin: const EdgeInsets.fromLTRB(5,5,0,5),
                      child: ItemDevice(device: _devices[index*2+1])
                      )
                    ],
                  );
                }
              }

            ),
          ],
        ),
      ),
      
    );
  }
}