import 'package:firebase_database/firebase_database.dart';

class Device {
  String title;
  bool status;
  String room;
  String typeDevice;
  int value;
  static List<Device> device =
      List.filled(0, Device("", "", false, "", 0), growable: true);
  Device(this.room, this.title, this.status, this.typeDevice, this.value);

  static Future<void> getListDevice(String? user) async {
    final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    var snapshot = await databaseReference.child('''
users/$user/room''').get();
    Map? data = snapshot.value as Map?;
    data?.forEach((roomName, lights) {
      if (lights is Map) {
        lights.forEach((lightName, lightData) {
          if (lightData is Map) {
            Device item = Device(
                roomName,
                lightName,
                lightData['Status'] ?? lightData['status'],
                lightData['TypeDevice'],
                lightData['value']);
            device.add(item);
            print(device);
          }
        });
      }
    });
  }

  static Future<void> getListDevicebyRoom(String? user, String room) async {
    final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    var snapshot = await databaseReference.child('''
users/$user/room''').get();
    Map? data = snapshot.value as Map?;

    var roomData = data?[room];
    if (roomData is Map) {
      roomData.forEach((lightName, lightData) {
        if (lightData is Map && lightData.isNotEmpty) {
          Device item = Device(
              room,
              lightName,
              lightData['Status'] ?? lightData['status'],
              lightData['TypeDevice'],
              lightData['value']);
          device.add(item);
        } else {
          device.clear();
        }
      });
    }
  }

  static Future<void> addDevice(
      String? user, String? room, String nameDevice, String? type) async {
    final DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref("users/$user/room/$room");
    databaseReference
        .child(nameDevice)
        .update({"status": false, "TypeDevice": type, "value": 0});
  }

  static Future<void> updateStatusDevice(
      String? user, String room, String nameDevice, bool status) async {
    final DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref("users/$user/room/$room");
    databaseReference.child(nameDevice).update({"status": status});
  }

  static Future<void> updateValueDevice(
      String? user, String room, String nameDevice, int value) async {
    final DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref("users/$user/room/$room");
    databaseReference.child(nameDevice).update({"value": value});
  }
}
