import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:myapp/pages/reset_pwd.dart';
import 'package:flutter/material.dart';
import 'package:myapp/utils.dart';

// ignore: camel_case_types
class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({super.key, required this.showRegisterPage});

  @override
  State<LoginPage> createState() => _homePageState();
}

// ignore: camel_case_types
class _homePageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;
  final _formKey = GlobalKey<FormBuilderState>();



  // ignore: non_constant_identifier_names
  Future<void> SignIn() async {
    try {
      if (_formKey.currentState!.saveAndValidate()) {
        setState(() {
          _loading = true;
        });

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    }
    }on FirebaseAuthException catch (e) {
        // Handle authentication failure and show an appropriate error message to the user
        if (e.code == 'user-not-found') {
          Utils.toast('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          Utils.toast('Wrong password provided for that user.');
        } else {
          Utils.toast("Check your password and email");
        }
        // Log the exception for debugging
        if (kDebugMode) {
          print('Firebase Auth Exception: $e');
        }
    }
    finally {
      // Dismiss the loading indicator
      setState(() {
        _loading = false;
      });

    }

  }


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 243, 239, 239),
          body: Center(
            child: FormBuilder(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.android,
                      size: 60,
                    ),
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
                        child: FormBuilderTextField(

                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(errorText: "Please enter Email"),
                            FormBuilderValidators.email(errorText: "Please enter valid email")
                          ]),
                          name: 'email',
                          controller: _emailController,
                          decoration: const InputDecoration(
                            hintText: 'Email',
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
                        child: FormBuilderTextField(
                          name: 'password',
                          controller: _passwordController,
                          decoration: const InputDecoration(
                            hintText: 'Password',
                          ),
                          obscureText: true,
                          validator: FormBuilderValidators.required(errorText: "Please enter password"),
                        ),

                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const ResetPasswordPage();
                              }));
                            },
                            child: const Text(
                              "Forgot your password?",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: _loading ? null: SignIn,
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 135, right: 135, top: 10, bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: _loading
                            ? const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              )
                            :
                        const Text(
                          "Sign In",
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
                          "Have no account?",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        GestureDetector(
                          onTap: widget.showRegisterPage,
                          child: const Text(
                            " Register here",
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
        ),
      ),
    );
  }
}
