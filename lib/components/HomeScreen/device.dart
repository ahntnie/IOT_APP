import 'dart:convert';
import 'dart:io';
import 'package:iot_app/components/model/db_reader.dart';

class Device{
  String url_image;
  String title;
  String room;
  bool status;
  Device(this.url_image,this.title,this.room,this.status);
  Device.fromJson(Map<String,dynamic> json):url_image = json['url_image'],
                                            title = json['title'],
                                            room = json['room'],
                                            status = json['status'];
  Map<String,dynamic> toJson()=>{
    "url_image" : url_image,
    "title" : title,
    "room" : room,
    "status" : status
  };
  static List<Device> devices = List.filled(0,Device("","","",false),growable: true);
  static Future<void> loadData() async{
    InfoReader reader = InfoReader();
    String data = await reader.getInfo();
    List<dynamic> lst = jsonDecode(data);
    for (var entry in lst) {
      devices.add(Device.fromJson(entry));
    }
  }

  static getListDevice(){
    return devices;
  }

  static getListDeviceByRoom(String room){
    List<Device> listDeviceInRoom = List.filled(0,Device("","","",false),growable: true);
    for (var item in devices) {
      if(item.room.compareTo(room)==0){
        listDeviceInRoom.add(item);
      }
    }
    return listDeviceInRoom;
  }
  static addNewDevice(Device device) {
    devices.add(device);
    InfoWriter writer = InfoWriter();
    writer.writeInfo(devices);
  }
  }
  class InfoWriter{
    Future<void> writeInfo(List<Device> devices) async {
      String data = jsonEncode(devices);
      File file = File("assets/device.json");
      await file.writeAsString(data);
    }
  }




  
