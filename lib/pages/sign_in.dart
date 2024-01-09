import 'package:flutter/foundation.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:myapp/auth/auth_service.dart';
import 'package:myapp/auth/reset_pwd.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils.dart';

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
  final _formKey = GlobalKey<FormBuilderState>();
  bool _passwordVisible = false;

  // ignore: non_constant_identifier_names
  Future SignIn() async {
    

    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signInWithEmailAndPassword(
          _emailController.text.trim(), _passwordController.text.trim(), context);
    

    //Navigator.of(context).pop();
    // Utils.toast("Login Successful");
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
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 243, 239, 239),
        body: Center(
          child: FormBuilder(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 15),
                    child: Image.asset(
                      "assets/screens/images/vector-1.png",
                      width: 413,
                      height: 457,
                    ),
                  ),
                  SafeArea(
                      child: Text(
                    "Log In",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: const Color(0xFF755DC1),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),

                    // style: TextStyle(
                    //   fontWeight: FontWeight.bold,
                    //   fontSize: 24,
                    // ),
                  )),
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
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.email(),
                        ]),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.emailAddress,
                        name: 'email',
                        controller: _emailController,
                        decoration: const InputDecoration(
                            labelText: 'Email',
                            hintText: 'Enter your email',
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                width: 1,
                                color: Color(0xFF837E93),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                width: 1,
                                color: Color(0xFF9F7BFF),
                              ),
                            )),
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
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
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: 'Enter your password'),
                          FormBuilderValidators.minLength(8),
                        ]),
                        name: 'password',
                        controller: _passwordController,
                        obscureText: !_passwordVisible,
                        decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: 'Enter you password',
                            border: InputBorder.none,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _passwordVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                width: 1,
                                color: Color(0xFF837E93),
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                width: 1,
                                color: Color(0xFF9F7BFF),
                              ),
                            )),
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const ResetPasswordPage();
                            }));
                          },
                          child: Text(
                            "Forgot your password?",
                            style: TextStyle(
                              color: Colors.deepPurple.shade900,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      if (_formKey.currentState!.saveAndValidate()) {
                        if (kDebugMode) {
                          print(_formKey.currentState!.value);
                        }
                        //Utils.toast("Login Successful");
                        SignIn();
                      } else {
                        if (kDebugMode) {
                          print(_formKey.currentState!.value);
                        }
                        Utils.toast("Validation Failed");
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 135, right: 135, top: 10, bottom: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF755DC1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        "Sign In",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
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
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      GestureDetector(
                        onTap: widget.showRegisterPage,
                        child: Text(
                          " Register here",
                          style: TextStyle(
                            color: Colors.deepPurple.shade900,
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
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
