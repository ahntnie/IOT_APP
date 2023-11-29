import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // Future<UserCredential> signInWithGoogle() async {
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //   final GoogleSignInAuthentication? googleAuth =
  //       await googleUser?.authentication;
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth?.accessToken,
  //     idToken: googleAuth?.idToken,
  //   );
  //   return await FirebaseAuth.instance.signInWithCredential(credential);
  // }

  final form_key = GlobalKey<FormState>();
  String txt = "";
  final email = TextEditingController();
  final password = TextEditingController();
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
                  "Hello!",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  controller: email,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                    labelText: 'Username',
                    hintText: 'Enter username',
                    icon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == "") {
                      return "Username is not empty";
                    }
                    return null;
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  controller: password,
                  obscureText: obs,
                  decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 15.0),
                      labelText: 'Password',
                      hintText: 'Enter password',
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
                    if (value == "") {
                      return "Password is not empty";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              // Dialog(
              //   child: Text(
              //     txt,
              //     style: const TextStyle(color: Colors.red, fontSize: 15),
              //   ),
              // ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(shape: const CircleBorder()),
                onPressed: () {
                  // if (form_key.currentState!.validate()) {
                  //   if (username.text == password.text) {
                  //     Navigator.popUntil(context, (route) => route.isFirst);
                  //     Navigator.pushNamed(context, '/home');
                  //   } else {
                  //     txt = "Sign In failed";
                  //   }
                  // }
                  try {
                    FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: email.text, password: password.text)
                        .then((value) {
                      Navigator.pushNamed(context, '/home');
                    }).onError((error, stackTrace) {
                      print("Error ${error.toString()}");
                    });
                  } catch (e) {
                    print("Error");
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
                      "Sign In",
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
              ElevatedButton(
                style: ElevatedButton.styleFrom(shape: const CircleBorder()),
                onPressed: () {},
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
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Sign In with ",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Image.asset(
                          "assets/icongg.jpg",
                          width: 30,
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 30, top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                        onTap: () {},
                        child: const Text(
                          "Forgot password?",
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "No account? ",
                      style: TextStyle(fontSize: 15),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.popUntil(context, (route) => route.isFirst);
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: const Text(
                        "Sign Up",
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
