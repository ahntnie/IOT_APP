import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  var username = FirebaseAuth.instance.currentUser?.displayName;
  var changeUsername = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        SizedBox(
          width: 230,
          height: 230,
          child: DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/user.jpg'),
                  radius: 50,
                ),
                MaterialButton(
                  onPressed: () {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text(
                              'Edit username',
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(15, 30, 15, 20),
                                    child: TextField(
                                      controller: changeUsername,
                                      decoration: const InputDecoration(
                                          label: Text('Username'),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5)))),
                                    ),
                                  )
                                ]),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('No')),
                              TextButton(
                                  style: const ButtonStyle(),
                                  onPressed: () async {
                                    User? user =
                                        FirebaseAuth.instance.currentUser;

                                    // Kiểm tra xem người dùng có tồn tại không
                                    if (user != null) {
                                      // Cập nhật display name
                                      await user.updateDisplayName(
                                          changeUsername.text);
                                      // final DatabaseReference
                                      //     databaseReference = FirebaseDatabase
                                      //         .instance
                                      //         .ref()
                                      //         .child('/users');

                                      // databaseReference
                                      //
                                      //     .update({
                                      //   user.displayName!: changeUsername.text
                                      // });
                                      // In thông báo sau khi cập nhật thành công
                                      print(
                                          'Display Name updated successfully to: ${user.displayName}');
                                    } else {
                                      print('User is null');
                                    }
                                    Navigator.popAndPushNamed(context, '/home');
                                    setState(() {
                                      username = changeUsername.text;
                                    });
                                  },
                                  child: const Text('Yes')),
                            ],
                          );
                        });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(username.toString(),
                            style: const TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold)),
                        Icon(Icons.edit),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        ListTile(
            title: const Text("Change Password"),
            leading: const Icon(Icons.edit),
            onTap: () {
              Navigator.popUntil(context, (route) => route.isFirst);
              Navigator.pushNamed(context, '/change-password');
            }),
        ListTile(
          title: Text("Setting"),
          leading: Icon(Icons.settings),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text("Log out"),
          leading: Icon(Icons.logout),
          onTap: () {
            FirebaseAuth.instance.signOut().then((value) {
              Navigator.pushNamed(context, '/signin');
            });
          },
        )
      ],
    ));
  }
}
