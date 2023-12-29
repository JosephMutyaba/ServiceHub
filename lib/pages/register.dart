import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../utils.dart';

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
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _imagePicker = ImagePicker();
  XFile? _profileImage;
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  bool _agreeToTerms = false;
  final _professionController = TextEditingController();
  bool _offerService = false;
  final _formKey = GlobalKey<FormBuilderState>();

  List<String> professions = [
    'electrician',
    'Doctor',
    'Teacher',
    'Lawyer',
    'Artist',
    'Scientist',
    'Police Officer',
    'Firefighter',
    'Architect',
    'Writer',
    'Graphic Designer',
    'Nurse',
    'Pilot',
    'Actor',
    'Musician',
    'Journalist',
    'Software Developer',
    'Entrepreneur',
    'Dentist',
    'Psychologist',
    'plumbing',
    'mechanic',
    'Social Worker',
    'carpenter',
    'key',
    'transport',
    'chef',
  ];

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
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        String imageUrl =
            _profileImage != null ? await uploadImage(_profileImage!) : '';

        addUser(
          _fNameController.text.trim(),
          _lNameController.text.trim(),
          _emailController.text.trim(),
          _phoneController.text.trim(),
          _addressController.text.trim(),
          imageUrl,
          _professionController.text.trim(),
          _offerService,
          0, //Initially 0 likes
          0, //Initially 0 rating
        );
      } on FirebaseAuthException catch (e) {
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message!),
            );
          },
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text("Passwords do not match"),
          );
        },
      );
    }
  }

  Future addUser(
      String fname,
      String lName,
      String email,
      String phone,
      String address,
      String imageUrl,
      String profession,
      bool serviceType,
      int likes,
      int rating) async {
    await FirebaseFirestore.instance.collection('user').add(
      {
        'fname': fname,
        'lName': lName,
        'email': email,
        'phone': phone,
        'address': address,
        'imageUrl': imageUrl,
        'profession': profession,
        'offer_servive': serviceType,
        'likes': likes,
        'rating': rating,
      },
    );
  }

  Future<String> uploadImage(XFile imageFile) async {
    File file = File(imageFile.path);

    final Reference ref = FirebaseStorage.instance
        .ref()
        .child('user_images')
        .child('${FirebaseAuth.instance.currentUser!.uid}.jpg');

    final UploadTask uploadTask = ref.putFile(file);

    final TaskSnapshot snapshot = await uploadTask;

    final String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  Future selectImage() async {
    final pickedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _profileImage = pickedImage;
      });
    }
  }

  @override
  void dispose() {
    _ageController.dispose();
    _lNameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _fNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _professionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
            title: const Text(
          "Register",
          textAlign: TextAlign.center,
        )),
        backgroundColor: const Color.fromARGB(255, 243, 239, 239),
        body: FormBuilder(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //const SizedBox(height: 10),
                // ... the icon or welcome message, if desired
                _profileImage != null
                    ? Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey,
                          backgroundImage: FileImage(File(_profileImage!.path)),
                        ),
                      )
                    : GestureDetector(
                        onTap: selectImage,
                        child: Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: const CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey,
                            child: Icon(Icons.add_a_photo),
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
                      keyboardType: TextInputType.name,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      name: 'firstName',
                      controller: _fNameController,
                      decoration: const InputDecoration(
                        hintText: 'First Name',
                        border: InputBorder.none,
                      ),
                      validator: FormBuilderValidators.required(),
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
                      validator: FormBuilderValidators.required(),
                      keyboardType: TextInputType.name,
                      name: 'lastName',
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
                        hintText: 'Email',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),

                FormBuilderCheckbox(
                  name: 'offerService',
                  initialValue: _offerService,
                  onChanged: (value) {
                    setState(() {
                      _offerService = value!;
                    });
                  },
                  title: const Text(
                    'I want to offer a service',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                // Replace this part of the code for the dropdown
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 247, 248, 248),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: _offerService
                        ? FormBuilderDropdown(
                            name: 'profession',
                            initialValue: _professionController.text.isNotEmpty
                                ? _professionController.text
                                : null,
                            items: professions.map((profession) {
                              return DropdownMenuItem(
                                value: profession,
                                child: Text(profession),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _professionController.text = value.toString();
                              });
                            },
                            validator: FormBuilderValidators.required(
                                errorText: 'Required'),
                            decoration: const InputDecoration(
                              hintText: 'Profession',
                              border: InputBorder.none,
                            ),
                          )
                        : const SizedBox.shrink(),
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
                      validator: FormBuilderValidators.required(
                          errorText: 'Enter your contact'),
                      keyboardType: TextInputType.phone,
                      name: 'phone',
                      controller: _phoneController,
                      decoration: const InputDecoration(
                        hintText: 'Phone Number',
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
                    child: FormBuilderTextField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: FormBuilderValidators.required(
                          errorText: 'Enter your address'),
                      keyboardType: TextInputType.streetAddress,
                      name: 'address',
                      controller: _addressController,
                      decoration: const InputDecoration(
                        hintText: 'Address',
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
                            errorText: 'Confirm your password'),
                        (value) {
                          if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ]),
                      name: 'confirmPassword',
                      controller: _confirmPasswordController,
                      obscureText: !_confirmPasswordVisible,
                      decoration: InputDecoration(
                        hintText: 'Confirm Password',
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _confirmPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _confirmPasswordVisible =
                                  !_confirmPasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),

                FormBuilderCheckbox(
                  name: 'acceptTerms',
                  initialValue: _agreeToTerms,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: 'Agree to continue!')
                  ]),
                  onChanged: (value) {
                    setState(() {
                      _agreeToTerms = value!;
                      if (value != true) {
                        Utils.toast("Agree to proceed");
                      }
                    });
                  },
                  title: const Text(
                    'I agree to the terms and conditions',
                    style: TextStyle(fontSize: 15),
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.saveAndValidate()) {
                      if (kDebugMode) {
                        print(_formKey.currentState!.value);
                      }
                      Utils.toast("Registration Successful");
                      register();
                    } else {
                      if (kDebugMode) {
                        print(_formKey.currentState!.value);
                      }
                      Utils.toast("Validation Failed");
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                      left: 135,
                      right: 135,
                      top: 10,
                      bottom: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      "Register",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
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
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
