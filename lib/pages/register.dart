import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

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
  bool _agreeToTerms = false;
  final _professionController = TextEditingController();
  bool _offerService = false;

  List<String> professions = [
    'Key Maker',
    'Doctor',
    'Teacher',
    'Lawyer',
    'Artist',
    'Scientist',
    'Chef',
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
    'Electrician',
    'Plumber',
    'Mechanic',
    'Social Worker',
    'Carpenter',
    'Transport'
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
          _passwordController.text.trim(),
          imageUrl,
          _professionController.text.trim(),
          _offerService,
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
      String password,
      String imageUrl,
      String profession,
      bool serviceType) async {
    await FirebaseFirestore.instance.collection('user').add(
      {
        'fname': fname,
        'lName': lName,
        'email': email,
        'phone': phone,
        'address': address,
        'password': password,
        'imageUrl': imageUrl,
        'profession': profession,
        'offer_servive': serviceType,
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
          title: Text("Registration"),
        ),
        backgroundColor: const Color.fromARGB(255, 243, 239, 239),
        body: SingleChildScrollView(
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

              //fjjf///////////////fhfhfh

              // Replace this part of the code for the dropdown
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 247, 248, 248),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButtonFormField(
                    value: _professionController.text.isNotEmpty
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
                    decoration: const InputDecoration(
                      hintText: 'Profession',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),

              // Checkbox for selecting whether to offer a service
              CheckboxListTile(
                value: _offerService,
                onChanged: (value) {
                  setState(() {
                    _offerService = value!;
                  });
                },
                title: const Text('I want to offer a service'),
              ),

              //jjfjjf//////////////////////////////fmf

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 247, 248, 248),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
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
                  child: TextField(
                    controller: _addressController,
                    decoration: const InputDecoration(
                      // padding: const EdgeInsets.only(left: 10),
                      // decoration: const InputDecoration(
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
                  child: TextField(
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
                  child: TextField(
                    controller: _confirmPasswordController,
                    obscureText: !_passwordVisible,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
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




                // child: TextField(
                //   controller: _confirmPasswordController,
                //   obscureText: !_passwordVisible,
                //   decoration: const InputDecoration(
                //     hintText: 'Confirm Password',
                //     border: InputBorder.none,
                //   ),
                // ),
              ),

              CheckboxListTile(
                value: _agreeToTerms,
                onChanged: (value) => setState(() => _agreeToTerms = value!),
                title: const Text('I agree to the terms and conditions'),
              ),

              GestureDetector(
                onTap: register,
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
    );
  }
}




// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

// class RegisterPage extends StatefulWidget {
//   final VoidCallback showLoginPage;
//   const RegisterPage({
//     super.key,
//     required this.showLoginPage,
//   });

//   @override
//   State<RegisterPage> createState() => _RegisterpageState();
// }

// class _RegisterpageState extends State<RegisterPage> {
//   final _confirmPasswordController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _fNameController = TextEditingController();
//   final _lNameController = TextEditingController();
//   final _ageController = TextEditingController();
//   final _phoneController = TextEditingController();
//   final _addressController = TextEditingController();
//   final _imagePicker = ImagePicker();
//   XFile? _profileImage;
//   bool _passwordVisible = false;
//   bool _agreeToTerms = false;

//   bool passwordEqual() {
//     if (_confirmPasswordController.text.trim() ==
//         _passwordController.text.trim()) {
//       return true;
//     } else {
//       return false;
//     }
//   }

//   Future register() async {
//     if (passwordEqual()) {
//       try {
//         await FirebaseAuth.instance.createUserWithEmailAndPassword(
//           email: _emailController.text.trim(),
//           password: _passwordController.text.trim(),
//         );

//         String imageUrl =
//             _profileImage != null ? await uploadImage(_profileImage!) : '';

//         addUser(
//           _fNameController.text.trim(),
//           _lNameController.text.trim(),
//           _emailController.text.trim(),
//           int.parse(_ageController.text.trim()),
//           _phoneController.text.trim(),
//           _addressController.text.trim(),
//           _passwordController.text.trim(),
//           imageUrl,
//         );
//       } on FirebaseAuthException catch (e) {
//         // ignore: use_build_context_synchronously
//         showDialog(
//           context: context,
//           builder: (context) {
//             return AlertDialog(
//               content: Text(e.message!),
//             );
//           },
//         );
//       }
//     } else {
//       showDialog(
//         context: context,
//         builder: (context) {
//           return const AlertDialog(
//             content: Text("Passwords do not match"),
//           );
//         },
//       );
//     }
//   }

//   Future addUser(
//     String fname,
//     String lName,
//     String email,
//     int age,
//     String phone,
//     String address,
//     String password,
//     String imageUrl,
//   ) async {
//     await FirebaseFirestore.instance.collection('user').add(
//       {
//         'fname': fname,
//         'lName': lName,
//         'email': email,
//         'age': age,
//         'phone': phone,
//         'address': address,
//         'password': password,
//         'imageUrl': imageUrl,
//       },
//     );
//   }

//   Future<String> uploadImage(XFile imageFile) async {
//     File file = File(imageFile.path);

//     final Reference ref = FirebaseStorage.instance
//         .ref()
//         .child('user_images')
//         .child('${FirebaseAuth.instance.currentUser!.uid}.jpg');

//     final UploadTask uploadTask = ref.putFile(file);

//     final TaskSnapshot snapshot = await uploadTask;

//     final String downloadUrl = await snapshot.ref.getDownloadURL();

//     return downloadUrl;
//   }

//   Future selectImage() async {
//     final pickedImage =
//         await _imagePicker.pickImage(source: ImageSource.gallery);
//     if (pickedImage != null) {
//       setState(() {
//         _profileImage = pickedImage;
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _ageController.dispose();
//     _lNameController.dispose();
//     _passwordController.dispose();
//     _confirmPasswordController.dispose();
//     _fNameController.dispose();
//     _emailController.dispose();
//     _phoneController.dispose();
//     _addressController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text("Registration"),
//         ),
//         backgroundColor: const Color.fromARGB(255, 243, 239, 239),
//         body: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const SizedBox(height: 40),
//               // ... the icon or welcome message, if desired
//               _profileImage != null
//                   ? Container(
//                       margin: const EdgeInsets.only(top: 20),
//                       child: CircleAvatar(
//                         radius: 50,
//                         backgroundColor: Colors.grey,
//                         backgroundImage: FileImage(File(_profileImage!.path)),
//                       ),
//                     )
//                   : GestureDetector(
//                       onTap: selectImage,
//                       child: Container(
//                         margin: const EdgeInsets.only(top: 20),
//                         child: const CircleAvatar(
//                           radius: 50,
//                           backgroundColor: Colors.grey,
//                           child: Icon(Icons.add_a_photo),
//                         ),
//                       ),
//                     ),

//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   padding: const EdgeInsets.only(left: 10),
//                   decoration: BoxDecoration(
//                     color: const Color.fromARGB(255, 247, 248, 248),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: TextField(
//                     controller: _fNameController,
//                     decoration: const InputDecoration(
//                       hintText: 'first name',
//                       border: InputBorder.none,
//                     ),
//                   ),
//                 ),
//               ),

//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   padding: const EdgeInsets.only(left: 10),
//                   decoration: BoxDecoration(
//                     color: const Color.fromARGB(255, 247, 248, 248),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: TextField(
//                     controller: _lNameController,
//                     decoration: const InputDecoration(
//                       hintText: 'last name',
//                       border: InputBorder.none,
//                     ),
//                   ),
//                 ),
//               ),

//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   padding: const EdgeInsets.only(left: 10),
//                   decoration: BoxDecoration(
//                     color: const Color.fromARGB(255, 247, 248, 248),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: TextField(
//                     controller: _emailController,
//                     decoration: const InputDecoration(
//                       hintText: 'Email',
//                       border: InputBorder.none,
//                     ),
//                   ),
//                 ),
//               ),

//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   padding: const EdgeInsets.only(left: 10),
//                   decoration: BoxDecoration(
//                     color: const Color.fromARGB(255, 247, 248, 248),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: TextField(
//                     controller: _ageController,
//                     decoration: const InputDecoration(
//                       hintText: 'age',
//                       border: InputBorder.none,
//                     ),
//                   ),
//                 ),
//               ),

//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   padding: const EdgeInsets.only(left: 10),
//                   decoration: BoxDecoration(
//                     color: const Color.fromARGB(255, 247, 248, 248),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: TextField(
//                     controller: _phoneController,
//                     decoration: const InputDecoration(
//                       hintText: 'Phone Number',
//                       border: InputBorder.none,
//                     ),
//                   ),
//                 ),
//               ),

//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   padding: const EdgeInsets.only(left: 10),
//                   decoration: BoxDecoration(
//                     color: const Color.fromARGB(255, 247, 248, 248),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: TextField(
//                     controller: _addressController,
//                     decoration: const InputDecoration(
//                       // padding: const EdgeInsets.only(left: 10),
//                       // decoration: const InputDecoration(
//                       hintText: 'Address',
//                       border: InputBorder.none,
//                     ),
//                   ),
//                 ),
//               ),

//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextField(
//                   controller: _passwordController,
//                   obscureText: !_passwordVisible,
//                   decoration: InputDecoration(
//                     hintText: 'Password',
//                     border: InputBorder.none,
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         _passwordVisible
//                             ? Icons.visibility_off
//                             : Icons.visibility,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           _passwordVisible = !_passwordVisible;
//                         });
//                       },
//                     ),
//                   ),
//                 ),
//               ),

//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextField(
//                   controller: _confirmPasswordController,
//                   obscureText: !_passwordVisible,
//                   decoration: const InputDecoration(
//                     hintText: 'Confirm Password',
//                     border: InputBorder.none,
//                   ),
//                 ),
//               ),

//               CheckboxListTile(
//                 value: _agreeToTerms,
//                 onChanged: (value) => setState(() => _agreeToTerms = value!),
//                 title: const Text('I agree to the terms and conditions'),
//               ),

//               GestureDetector(
//                 onTap: register,
//                 child: Container(
//                   padding: const EdgeInsets.only(
//                     left: 135,
//                     right: 135,
//                     top: 10,
//                     bottom: 10,
//                   ),
//                   decoration: BoxDecoration(
//                     color: Colors.blue,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: const Text(
//                     "Register",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 20,
//                     ),
//                   ),
//                 ),
//               ),

//               const SizedBox(
//                 height: 20,
//               ),

//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text(
//                     "Already have an account?",
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 15,
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: widget.showLoginPage,
//                     child: const Text(
//                       " Login here",
//                       style: TextStyle(
//                         color: Colors.blue,
//                         fontSize: 15,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 40),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
