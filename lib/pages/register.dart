import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({
    super.key,
    required this.showLoginPage,
  });

  @override
  State<RegisterPage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<RegisterPage> {
  final _confirmPasswordController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _fNameController = TextEditingController();
  final _lNameController = TextEditingController();
  final _ageController = TextEditingController();

  @override
  void dispose() {
    _ageController.dispose();
    _lNameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _fNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  bool passwordEqual() {
    if (_confirmPasswordController.text.trim() ==
        _passwordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  Future register() async {
    if (passwordEqual()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      addUser(
        _fNameController.text.trim(),
        _lNameController.text.trim(),
        _emailController.text.trim(),
        int.parse(_ageController.text.trim()),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text("Passwords do no match"),
          );
        },
      );
    }
  }

  // Future<void> register() async {
  //   if (passwordEqual()) {
  //     try {
  //       // Create user with Firebase Authentication
  //       await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //         email: _emailController.text.trim(),
  //         password: _passwordController.text.trim(),
  //       );

  //       // Add user data to Cloud Firestore
  //       addUser(
  //         _fNameController.text.trim(),
  //         _lNameController.text.trim(),
  //         _emailController.text.trim(),
  //         int.parse(_ageController.text.trim()),
  //       );

  //       // Navigate to the login page or any other page as needed
  //       widget.showLoginPage();
  //     } catch (e) {
  //       // Handle registration errors
  //       print("Error during registration: $e");
  //     }
  //   }
  // }

  Future addUser(String fname, String lName, String email, int age) async {
    await FirebaseFirestore.instance
        .collection('user')
        .add({'fname': fname, 'lName': lName, 'email': email, 'age': age});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 243, 239, 239),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // const Icon(
                //   Icons.android,
                //   size: 60,
                // ),
                const Text(
                  "Hello welcome!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 247, 248, 248),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _fNameController,
                      decoration: const InputDecoration(
                        hintText: 'first name',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 247, 248, 248),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _lNameController,
                      decoration: const InputDecoration(
                        hintText: 'last name',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 247, 248, 248),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 247, 248, 248),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _ageController,
                      decoration: const InputDecoration(
                        hintText: 'age',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 247, 248, 248),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      obscureText: true,
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 247, 248, 248),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      obscureText: true,
                      controller: _confirmPasswordController,
                      decoration: const InputDecoration(
                        hintText: 'Confirm Password',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: register,
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 135, right: 135, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      "Register",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.showLoginPage,
                      child: const Text(
                        " Login here",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
