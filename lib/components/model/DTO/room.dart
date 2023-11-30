import 'dart:async';

import 'package:firebase_database/firebase_database.dart';

class Room {
  String nameRoom;
  Room(this.nameRoom);
  static List<String> listRoom = [];

  static Future<void> getListRoom(String? user) async {
    final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    var snapshot = await databaseReference.child('''
users/$user/room''').get();
    for (final room in snapshot.children) {
      listRoom.add(room.key.toString());
    }
    print(listRoom);
  }

  static void addRoom(String room, String? user) {
    final DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref("users/$user");
    databaseReference.child("room").update({room: ""});
  }

  static void EditRoom(String roomOld, String roomNew, String? user) {
    final DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref("users/$user/room");
    databaseReference.child(roomOld).once().then((value) {
      Object? data = value.snapshot.value;
      databaseReference.child(roomNew).set(data).then((value) {
        databaseReference.child(roomOld).remove();
      });
    });
  }

  static void DeleteRoom(String room, String? user) {
    final DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref("users/$user/room");
    databaseReference.child(room).remove();
  }
}
