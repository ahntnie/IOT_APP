import 'dart:async';

import 'package:firebase_database/firebase_database.dart';

class Room {
  String nameRoom;
  Room(this.nameRoom);
  static List<String> listRoom = [];
  static final DatabaseReference databaseReference =
      FirebaseDatabase.instance.ref();
  static Future<void> getListRoom() async {
    var snapshot = await databaseReference.child('''
room''').get();
    for (final room in snapshot.children) {
      listRoom.add(room.key.toString());
    }
    print(listRoom);
  }
}
