import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/auth/auth_service.dart';
import 'package:myapp/utils.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({
    super.key,
    required this.showLoginPage,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _professionDescriptionController = TextEditingController();
  final _hourlyRateController = TextEditingController();
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
        // showDialog(
        //   context: context,
        //   builder: ((context) {
        //     return const Center(child: CircularProgressIndicator());
        //   }),
        // );

        final authService = Provider.of<AuthService>(context, listen: false);

        User? signedUpUser = await authService.signUpWithEmailAndPassword(
          _passwordController.text.trim(),
          _emailController.text.trim(), context
        );

        String imageUrl =
            _profileImage != null ? await uploadImage(_profileImage!) : '';
        if (!_offerService) {
          _professionDescriptionController.text = '';
        }
        int hourlyRate = _offerService ? int.parse(_hourlyRateController.text.trim()) : 0;


        authService.addUser(
          signedUpUser!,
          _fNameController.text.trim(),
          _lNameController.text.trim(),
          _emailController.text.trim(),
          _phoneController.text.trim(),
          _addressController.text.trim(),
          imageUrl,
          _professionController.text.trim(),
          _professionDescriptionController.text
              .trim(), // description is to be filled in the profile page
          _offerService,
          hourlyRate, //hourlyRate is filled in at the edit profile page
          0, //Initially 0 likes
          0, //Initially 0 rating
        );

        if (!mounted) return;
        //Navigator.of(context).pop();
        Utils.toast("Registration Successful");
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
    //print("Selecting image...");
    try {
      final pickedImage =
          await _imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        //print("Image selected: ${pickedImage.path}");
        setState(() {
          _profileImage = pickedImage;
        });
      } else {
        //print("Image selection canceled");
      }
    } catch (e) {
      //print("Error selecting image: $e");
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
    _professionDescriptionController.dispose();
    _hourlyRateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 243, 239, 239),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/screens/images/vector-2.png"), // Replace with your image path
              scale: 0.5,
              alignment: Alignment.topCenter,
              opacity: 0.9,
            ),
          ),
          child: FormBuilder(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 40,
                  ),

               Text(
              "Register",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: const Color(0xFF755DC1),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 30,
                ),
                textAlign: TextAlign.start,
              ),
                  const SizedBox(
                    height: 40,
                  ),
                  Stack(
                    children: [
                      SizedBox(
                          width: 120,
                          height: 120,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: _profileImage != null
                                ? FileImage(File(_profileImage!.path))
                                : const AssetImage('assets/screens/profile.png')
                                    as ImageProvider<Object>,
                          )),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.black.withOpacity(0.5)),
                          child: IconButton(
                            icon: const Icon(Icons.camera_alt),
                            color: Colors.white,
                            onPressed: () {
                              selectImage();
                            },
                          ),
                        ),
                      ),
                    ],
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
                        textCapitalization: TextCapitalization.words,
                        validator: FormBuilderValidators.required(),
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
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
                        validator: FormBuilderValidators.required(),
                        keyboardType: TextInputType.name,
                        name: 'lastName',
                        controller: _lNameController,
                        decoration: const InputDecoration(
                          hintText: 'last name',
                          border: InputBorder.none,
                        ),
                        textCapitalization: TextCapitalization.words,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
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
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
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
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),

                  Visibility(
                      visible: _offerService,
                      child: Column(
                        children: [

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: const EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 247, 248, 248),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: FormBuilderDropdown(
                                name: 'profession',
                                initialValue: _professionController.text.isNotEmpty
                                    ? _professionController.text
                                    : null,
                                items: professions.map((profession) {
                                  return DropdownMenuItem(
                                    value: profession,
                                    child: Text(profession,
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: Colors.black,
                                      )
                                    ),
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
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
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
                                    errorText: 'Describe your professional experience'),
                                keyboardType: TextInputType.multiline,
                                name: 'professional experience',
                                controller: _professionDescriptionController,
                                decoration: const InputDecoration(
                                  hintText: 'Describe your professional experience',
                                  border: InputBorder.none,
                                ),
                                textCapitalization: TextCapitalization.sentences,
                                textInputAction: TextInputAction.newline,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
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
                                    errorText: 'Enter your hourly rate in UGX'),
                                keyboardType: TextInputType.streetAddress,
                                name: 'hourly rate',
                                controller: _hourlyRateController,
                                decoration: const InputDecoration(
                                  hintText: 'Hourly Rate',
                                  border: InputBorder.none,
                                ),
                                textCapitalization: TextCapitalization.words,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),

                        ],
                      )
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
                      child: FormBuilderTextField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: 'Enter your contact'),
                          FormBuilderValidators.minLength(10, errorText: 'Enter 10 digits'),
                          FormBuilderValidators.maxLength(10, errorText: 'Digits should not exceed 10'),
                        ]),
                        keyboardType: TextInputType.phone,
                        name: 'phone',
                        controller: _phoneController,
                        decoration: const InputDecoration(
                          hintText: 'Phone Number',
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
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
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
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
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
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
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
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
                      style: TextStyle(fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins'
                      ),

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
                        left: 120,
                        right: 120,
                        top: 10,
                        bottom: 10,
                      ),
                      decoration: BoxDecoration(
                          color: const Color(0xFF755DC1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        "Register",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
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
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      GestureDetector(
                        onTap: widget.showLoginPage,
                        child: Text(
                          " Login here",
                          style: TextStyle(
                            color: Colors.deepPurple.shade900,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins'
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
      ),
    );
  }
}
