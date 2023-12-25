import 'package:myapp/pages/register.dart';
import 'package:myapp/pages/sign_in.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showAuthPage = true;

  void togglePage() {
    setState(() {
      showAuthPage = !showAuthPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showAuthPage) {
      return LoginPage(showRegisterPage: togglePage);
    }else{
      return RegisterPage(showLoginPage: togglePage);
    }
  }
}
