
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:myapp/screens/categories.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:myapp/utils.dart';

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
  final _formKey = GlobalKey<FormBuilderState>();
  bool _loading = false;
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


  Future<void> register() async {
    try {

        if (_formKey.currentState!.saveAndValidate()) {
          setState(() {
            _loading = true;
          });

          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );

          await addUser(
            _fNameController.text.trim(),
            _lNameController.text.trim(),
            _emailController.text.trim(),
            int.parse(_ageController.text.trim()),
          );

          // Uncomment the line below and use it to navigate to the login page
          //widget.showLoginPage();

          // You may choose to navigate to a different page after successful registration
          if (!mounted) return;
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const Scene()));
        }
    } catch (e) {
      if (e is FirebaseAuthException) {
        // Handle Firebase Authentication errors
        if (e.code == 'email-already-in-use') {
          // Email is already associated with an existing account
          Utils.toast("Email already exists. Please use a different email.", success: false);
        } else {
          // Handle other Firebase Authentication errors
          Utils.toast("Error during registration: ${e.message}", success: false);
        }
      } else {
        // Handle non-Firebase exceptions
        if (kDebugMode) {
          print("Error during registration: $e");
        }
        // Utils.toast("Error during registration", success: false);
      } } finally {
      setState(() {
        _loading = false;
      });
    }
  }

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
          child: FormBuilder(
            key: _formKey,

            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                        name: 'first_name',
                        controller: _fNameController,
                        decoration: const InputDecoration(
                          hintText: 'First Name',
                        ),
                        validator: FormBuilderValidators.required(errorText: "Enter first name"),
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
                        name: 'last_name',
                        controller: _lNameController,
                        decoration: const InputDecoration(
                          hintText: 'Last Name',
                        ),
                        validator: FormBuilderValidators.required(errorText: "Enter last name"),
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
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        name: 'email',
                        controller: _emailController,
                        decoration: const InputDecoration(
                          hintText: 'Email',
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.email(errorText: "Enter valid email"),
                          FormBuilderValidators.required(errorText: "Enter email"),
                        ])
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
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                          name: 'age',
                          controller: _ageController,
                          decoration: const InputDecoration(
                            hintText: 'Age',
                          ),
                          validator: FormBuilderValidators.compose([
                          FormBuilderValidators.numeric(errorText: "Enter a number"),
                          FormBuilderValidators.required(),
                            FormBuilderValidators.max(80),
                            FormBuilderValidators.min(18)
                          ])

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
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: 'Password',
                        ),
                        validator: FormBuilderValidators.required(errorText: "Enter a password"),
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
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        name: 'confirm_password',
                        controller: _confirmPasswordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: 'Confirm Password',
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(errorText: "Enter same password"),
                              (val) {
                            if (val != _passwordController.text) {
                              return "Passwords don't match";
                            }
                            return null;
                          },
                        ])

                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: _loading ? null : register,
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
                              )
                            )
                          :
                      const Text(
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
      ),
    );
  }
}
