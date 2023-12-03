import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:iot_app/components/SignIn_SignUp/signin.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final form_key = GlobalKey<FormState>();
  String txt = "";
  final fullname = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final cfpassword = TextEditingController();
  bool obs = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: form_key,
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                padding: const EdgeInsets.only(top: 80, left: 20),
                child: const Text(
                  "Sign Up",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 15),
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  controller: fullname,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                    labelText: 'Fullname',
                    icon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your fullname';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 15),
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  controller: email,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                      labelText: 'Email',
                      icon: Icon(Icons.email_rounded)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!EmailValidator.validate(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 15),
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  controller: password,
                  obscureText: obs,
                  decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 15.0),
                      labelText: 'Password',
                      icon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: obs
                            ? const Icon(Icons.visibility_off_rounded)
                            : const Icon(Icons.remove_red_eye),
                        onPressed: () {
                          setState(() {
                            obs = !obs;
                          });
                        },
                      )),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 15),
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  controller: cfpassword,
                  obscureText: obs,
                  decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 15.0),
                      labelText: 'Confirm password',
                      icon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: obs
                            ? const Icon(Icons.visibility_off_rounded)
                            : const Icon(Icons.remove_red_eye),
                        onPressed: () {
                          setState(() {
                            obs = !obs;
                          });
                        },
                      )),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    } else if (value != password.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    txt,
                    style: TextStyle(color: Colors.red, fontSize: 15),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(shape: const CircleBorder()),
                onPressed: () {
                  if (form_key.currentState != null &&
                      form_key.currentState!.validate()) {
                    FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: email.text, password: password.text)
                        .then((value) {
                      FirebaseAuth.instance.currentUser
                          ?.updateDisplayName(fullname.text);
                      DatabaseReference ref = FirebaseDatabase.instance.ref();
                      ref.child("users").update({fullname.text: ""});
                      print("Created new account");

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignIn()));
                    }).onError((error, stackTrace) {
                      print("Error ${error.toString()}");
                    });
                  } else {
                    setState(() {
                      txt = "Please fill in all the fields";
                    });
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          spreadRadius: 0.3,
                          blurRadius: 6,
                        )
                      ]),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 15,
                  child: const Center(
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Had account?",
                      style: TextStyle(fontSize: 15),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.popUntil(context, (route) => route.isFirst);
                        Navigator.pushNamed(context, '/signin');
                      },
                      child: const Text(
                        "Sign In",
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
