import 'package:flutter/foundation.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
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
    showDialog(
      context: context,
      builder: ((context) {
        return const Center(child: CircularProgressIndicator());
      }),
    );

    // await FirebaseAuth.instance.signInWithEmailAndPassword(
    //   email: _emailController.text.trim(),
    //   password: _passwordController.text.trim(),
    // );
    final authService = Provider.of<AuthService>(context, listen: false);
    //use of state manager provider
    try {
      authService.signInWithEmailAndPassword(
          _emailController.text.trim(), _passwordController.text.trim());
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }

    //dismiss the circular progress indicator
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
    Utils.toast("Login Successful");
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
         appBar: AppBar(
          title:  Text("Login",
            textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium,
          ),

        ),
        backgroundColor: const Color.fromARGB(255, 243, 239, 239),
        body: Center(
          child: FormBuilder(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // const Icon(
                  //   Icons.android,
                  //   size: 60,
                  // ),
                  Center(
                    child: Image.asset(
                      "assets/screens/images/logo-no-background.png",
                      height: 100,
                      width: 300,
                      scale: 0.5,
                    ),
                  ),

                   SafeArea(
                      child: Text(
                    "Hello welcome!",
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.deepPurple.shade900,
                          fontWeight: FontWeight.bold,
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
                      child:  FormBuilderTextField(
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.email(),
                        ]),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.emailAddress,
                        name: 'email',
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
                      child:  FormBuilderTextField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(errorText: 'Enter your password'),
                          FormBuilderValidators.minLength(8),
                        ]),
                        name: 'password',
                        controller: _passwordController,
                        obscureText: !_passwordVisible,
                        decoration: InputDecoration(
                          hintText: 'Password',
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
                        ),
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
                          child:  Text(
                            "Forgot your password?",
                            style: TextStyle(
                              color: Colors.deepPurple.shade900,
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
                    onTap: (){
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
                        color: Colors.deepPurple.shade900,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
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
                        child:  Text(
                          " Register here",
                          style: TextStyle(
                            color: Colors.deepPurple.shade900,
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
