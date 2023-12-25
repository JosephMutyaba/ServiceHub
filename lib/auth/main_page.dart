import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetask/auth/auth_page.dart';
import 'package:firebasetask/pages/page_one.dart';
import 'package:flutter/material.dart';

class MainPage1 extends StatefulWidget {
  const MainPage1({super.key});

  @override
  State<MainPage1> createState() => _MainPage1State();
}

class _MainPage1State extends State<MainPage1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            return const PageOne();
          } else {
            return const AuthPage();
          }
        },
      ),
    );
  }
}
