import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/auth/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:myapp/professional_categories.dart';

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

            return const MyApp24();
          } else {
            return const AuthPage();
          }
        },
      ),
    );
  }
}
