import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/firebase_options.dart';

class Registerview extends StatefulWidget {
  const Registerview({super.key});

  @override
  State<Registerview> createState() => _RegisterviewState();
}

class _RegisterviewState extends State<Registerview> {
  late final TextEditingController email;
  late final TextEditingController password;

  @override
  void initState() {
    email = TextEditingController();
    password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login page"),
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return Column(
                children: [
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration:
                        const InputDecoration(hintText: "Enter your email"),
                    controller: email,
                  ),
                  TextField(
                    controller: password,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration:
                        const InputDecoration(hintText: "Enter password"),
                  ),
                  TextButton(
                    onPressed: () async {
                      final emailofuser = email.text;
                      final passwordofuser = password.text;
                      try {
                        final UserCredential = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: emailofuser,
                          password: passwordofuser,
                        );
                        print(UserCredential);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == "weak-password") {
                          print("give strong code");
                        } else if (e.code == "email-already-in-use") {
                          print("email already in use");
                        } else if (e.code == "invalid-email") {
                          print("invalid email");
                        }
                      }
                    },
                    child: const Text("Create account"),
                  ),
                ],
              );
            default:
              return const Text("Loading...");
          }
        },
      ),
    );
  }
}
