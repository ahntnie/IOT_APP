import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iot_app/components/SignIn_SignUp/signin.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? currentUser = _auth.currentUser;

    String password = SignIn.pass;

    var passOld = TextEditingController();
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
              controller: passOld,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  label: const Text("Password Old"),
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
              controller: passNew,
              keyboardType: TextInputType.text,
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
              controller: confirmPassNew,
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
                if (passNew.text.isEmpty ||
                    confirmPassNew.text.isEmpty ||
                    passOld.text.isEmpty) {
                  showalert(context, "Thông tin mật khẩu không được để trống",
                      () {
                    Navigator.pop(context);
                  });
                } else if (passOld.text != password) {
                  print(password);
                  showalert(context, "Thông tin mật khẩu cũ không đúng", () {
                    Navigator.pop(context);
                  });
                } else if (passNew.text != confirmPassNew.text) {
                  showalert(context,
                      "Mật khẩu mới và nhập lại mật khẩu không trùng khớp", () {
                    Navigator.pop(context);
                  });
                } else {
                  try {
                    await currentUser?.updatePassword(passNew.text);
                    showalert(context,
                        "Đổi mật khẩu thành công vui lòng đăng nhập lại", () {
                      Navigator.popAndPushNamed(context, '/signin');
                    });
                    // Navigator.popAndPushNamed(context, '/Signin');
                  } catch (e) {
                    showalert(context, "Đổi mật khẩu thất bại", () {
                      Navigator.pop(context);
                    });
                  }
                }
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

showalert(BuildContext context, String content, void Function() callback) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Thông báo",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  callback();
                },
                child: const Text('OK')),
          ],
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.warning, size: 70),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(content),
              ),
            ],
          ),
        );
      });
}
