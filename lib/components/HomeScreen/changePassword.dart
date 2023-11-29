import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth _auth = FirebaseAuth.instance;

    final currentUser = FirebaseAuth.instance.currentUser;
    var passNew = TextEditingController();
    var confirmPassNew = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Password"),
        leading: IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, '/home');
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  label: const Text("New Password"),
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: TextField(
              decoration: InputDecoration(
                  label: const Text("Confirm new Password"),
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: TextButton(
              onPressed: () async {
                if (passNew.text.isEmpty || confirmPassNew.text.isEmpty) {
                  showalert(context, "Thông tin mật khẩu không được để trống");
                } else if (passNew.text != confirmPassNew.text) {
                  showalert(context,
                      "Mật khẩu mới và nhập lại mật khẩu không trùng khớp");
                } else {}
              },
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.blue),
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: const Text(
                  "Save",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

showalert(BuildContext context, String content) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Thông báo"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK')),
          ],
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.warning, size: 50),
              Text(content),
            ],
          ),
        );
      });
}
