import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';
import '../utils.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key,required this.userData});
  final Map<String, dynamic> userData;


  @override
  // ignore: library_private_types_in_public_api
  _EditProfilePageState createState() => _EditProfilePageState();
}
class _EditProfilePageState extends State<UpdateProfileScreen> {
  late TextEditingController _fnameController;
  late TextEditingController _lNameController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  final _formKey = GlobalKey<FormBuilderState>();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  Uint8List? _image;


   late String _imageUrl;

  @override
  void initState() {
    super.initState();
    _fnameController = TextEditingController(text: widget.userData['fname']);
    _lNameController = TextEditingController(text: widget.userData['lName']);
    _phoneController = TextEditingController(text: widget.userData['phone']);
    _addressController = TextEditingController(text: widget.userData['address']);
    _imageUrl = widget.userData['imageUrl'] ?? '';

    // Initialize _profileImage with the current user image URL

  }

  Future<void> _saveChanges() async {
    try {
      // Get the current user's email
      String currentUserEmail = FirebaseAuth.instance.currentUser!.email!;

      // Get the reference to the user's document in Firestore based on the email
      QuerySnapshot<Map<String, dynamic>> userSnapshot = await FirebaseFirestore
          .instance
          .collection('user')
          .where('email', isEqualTo: currentUserEmail)
          .limit(1)
          .get();

      if (userSnapshot.docs.isNotEmpty) {
        // Update the document with the new data
        await userSnapshot.docs.first.reference.update({
          'fname': _fnameController.text.trim(),
          'lName': _lNameController.text.trim(),
          'phone': _phoneController.text.trim(),
          'address': _addressController.text.trim(),
          // ignore: unnecessary_null_comparison
          'imageUrl': _imageUrl != null
              ? await uploadImage('user_images', _image!)
              : widget
              .userData['imageUrl'], // Keep existing image if not changed
        });

        // Show a success message or handle it as needed
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully'),
            backgroundColor: Colors.green,
            elevation: 10,
          ),
        );

        // Close the screen and pass the updated data back to the previous screen
        Navigator.pop(context, true);
      } else {
        // Handle the case where user data doesn't exist
        print('User data not found');
      }
    } catch (e) {
      // Handle errors, show error message, etc.
      print('Error updating profile: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Error updating profile. Please try again.')),
      );
    }
  }

  Future<String> uploadImage(String childName, Uint8List file) async {
    // File file = File(imageFile.path);
    //
    final Reference ref = _storage
        .ref()
        .child(childName);
    final UploadTask uploadTask = ref.putData(file);
    final TaskSnapshot snapshot = await uploadTask;
    final String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;


    // final UploadTask uploadTask = ref.putFile(file);
    //
    // final TaskSnapshot snapshot = await uploadTask;
    //
    // final String downloadUrl = await snapshot.ref.getDownloadURL();
    //
    // return downloadUrl;
  }

  Future selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image =img;
    });

  }

  @override
  void dispose() {
    _fnameController.dispose();
    _lNameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back_ios)),
        title: Text("Edit Profile", style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              // -- IMAGE with ICON
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: CircleAvatar(
                        radius: 60,
                        backgroundImage: _image != null
                              ? MemoryImage(_image!)
                              : NetworkImage(_imageUrl)
                          as ImageProvider<Object>,
                  )),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.deepPurple),
                      child:  IconButton(
                        icon: const Icon(Icons.camera_alt),
                        color: Colors.black,
                        onPressed: () {
                          selectImage();
                        },),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),

              // -- Form Fields
              FormBuilder(
                key: _formKey,
                child: Column(
                  children: [
                    FormBuilderTextField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.name,
                      validator: FormBuilderValidators.required(),
                      name: 'fname',
                      controller: _fnameController,
                      decoration: const InputDecoration(
                          label: Text("FirstName"),
                          prefixIcon: Icon(Icons.person),
                        border: InputBorder.none
                      ),
                    ),
                    FormBuilderTextField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.name,
                      name: 'lName',
                      validator: FormBuilderValidators.required(),
                      controller: _lNameController,
                      decoration: const InputDecoration(
                          label: Text("LastName"),
                          prefixIcon: Icon(Icons.person_outline),
                          border: InputBorder.none
                      ),
                    ),
                    const SizedBox(height: 10),
                    FormBuilderTextField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.phone,
                      name: 'phone',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.numeric(),
                      ]),
                      controller: _phoneController,
                      decoration: const InputDecoration(
                          label: Text("Phone"),
                          prefixIcon: Icon(Icons.phone),
                          border: InputBorder.none
                      ),
                    ),
                    const SizedBox(height: 10),
                    FormBuilderTextField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: FormBuilderValidators.required(),
                      keyboardType: TextInputType.streetAddress,
                      name: 'address',
                      controller: _addressController,
                      decoration: const InputDecoration(
                          label: Text("Address"),
                          prefixIcon: Icon(Icons.home),
                          border: InputBorder.none
                      ),
                    ),
                    const SizedBox(height: 10),
                    // TextFormField(
                    //   obscureText: true,
                    //   decoration: InputDecoration(
                    //     label: const Text("Password"),
                    //     prefixIcon: const Icon(Icons.fingerprint),
                    //     suffixIcon:
                    //     IconButton(icon: const Icon(Icons.remove_red_eye), onPressed: () {}),
                    //   ),
                    // ),
                    const SizedBox(height: 30),

                    // -- Form Submit Button
                    SizedBox(
                      width: 180,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.saveAndValidate()) {
                            if (kDebugMode) {
                              print(_formKey.currentState!.value);
                            }
                            //Utils.toast("Login Successful");
                            _saveChanges();
                          } else {
                            if (kDebugMode) {
                              print(_formKey.currentState!.value);
                            }
                            Utils.toast("Validation Failed");
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            side: BorderSide.none,
                            shape: const StadiumBorder()),
                        child: const Text("Save", style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // -- Created Date and Delete Button
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     const Text.rich(
                    //       TextSpan(
                    //         text: "tJoined",
                    //         style: TextStyle(fontSize: 12),
                    //         children: [
                    //           TextSpan(
                    //               text: "tJoinedAt",
                    //               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))
                    //         ],
                    //       ),
                    //     ),
                    //     ElevatedButton(
                    //       onPressed: () {},
                    //       style: ElevatedButton.styleFrom(
                    //           backgroundColor: Colors.redAccent.withOpacity(0.1),
                    //           elevation: 0,
                    //           foregroundColor: Colors.red,
                    //           shape: const StadiumBorder(),
                    //           side: BorderSide.none),
                    //       child: const Text("tDelete"),
                    //     ),
                    //   ],
                    // )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}