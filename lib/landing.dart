import 'package:firebase/home.dart';
import 'package:firebase/services/auth.dart';
import 'package:firebase/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Landing extends StatelessWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Auth();

    return StreamBuilder<User?>(
        stream: auth.getAuthState,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const Home();
          } else {
            return const SignIn();
          }
        });
  }
}
