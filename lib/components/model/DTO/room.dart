import 'dart:async';

import 'package:firebase_database/firebase_database.dart';

class Room {
  String nameRoom;
  Room(this.nameRoom);
  static List<String> listRoom = [];

  static Future<void> getListRoom() async {
    final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    var snapshot = await databaseReference.child('''
users/cvinh/room''').get();
    for (final room in snapshot.children) {
      listRoom.add(room.key.toString());
    }
    print(listRoom);
  }

  static void addRoom(String room) {
    final DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref("users/cvinh");
    databaseReference.child("room").update({room: ""});
  }

  static void EditRoom(String roomOld, String roomNew) {
    final DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref("users/cvinh/room");
    databaseReference.child(roomOld).once().then((value) {
      Object? data = value.snapshot.value;
      databaseReference.child(roomNew).set(data).then((value) {
        databaseReference.child(roomOld).remove();
      });
    });
  }

  static void DeleteRoom(String room) {
    final DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref("users/cvinh/room");
    databaseReference.child(room).remove();
  }
}
