// ignore_for_file: use_build_context_synchronously

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
  late TextEditingController _descriptionController;
  late TextEditingController _hourlyRateController;
  final _formKey = GlobalKey<FormBuilderState>();
  late bool offerService = false;
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
    _descriptionController = TextEditingController(text: widget.userData['description']);
    _hourlyRateController = TextEditingController(text: widget.userData['hourlyRate'].toString());
    offerService = widget.userData['offer_servive'];
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
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .where('email', isEqualTo: currentUserEmail)
          .limit(1)
          .get();

      if (userSnapshot.docs.isNotEmpty) {
        // Update the document with the new data
        int hourlyRate = int.parse(_hourlyRateController.text.trim());
        // ignore: unnecessary_null_comparison
        String profileImageUrl = _imageUrl != null
            ? await uploadImage('user_images', _image!)
            : widget.userData['imageUrl'];

        await userSnapshot.docs.first.reference.update({
          'fname': _fnameController.text.trim(),
          'lName': _lNameController.text.trim(),
          'phone': _phoneController.text.trim(),
          'address': _addressController.text.trim(),
          'description': _descriptionController.text.trim(),
          'hourlyRate': hourlyRate,
          'imageUrl': profileImageUrl, // Keep existing image if not changed
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

    final Reference ref = _storage
        .ref()
        .child(childName)
        .child(FirebaseAuth.instance.currentUser!.uid);
    final UploadTask uploadTask = ref.putData(file);
    final TaskSnapshot snapshot = await uploadTask;
    final String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;

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
    _descriptionController.dispose();
    _hourlyRateController.dispose();
    offerService = false;
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
          }, icon: const Icon(Icons.arrow_back_ios)),
        title: Text("Edit Profile",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins'
            )
        ),
        backgroundColor: const Color(0xFF755DC1),
        iconTheme: const IconThemeData(color: Colors.white),
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
                          : (_imageUrl.isNotEmpty
                          ? NetworkImage(_imageUrl)
                          : const AssetImage('assets/screens/profile.png')) as ImageProvider<Object>,


                    )),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(100),
                          color: Colors.black.withOpacity(0.5)),
                      child:  IconButton(
                        icon: const Icon(Icons.camera_alt),
                        color: Colors.white,
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
                    Container(
                      decoration: BoxDecoration(
                          // color: const Color.fromARGB(255, 247, 248, 248),
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.deepPurple.shade200)
                      ),
                      child: FormBuilderTextField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.name,
                        validator: FormBuilderValidators.required(),
                        name: 'fname',
                        controller: _fnameController,
                        decoration:  InputDecoration(
                            labelText: "FirstName",
                            floatingLabelStyle: TextStyle(
                              color: Colors.deepPurple.shade900,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500
                            ),
                            prefixIcon: const Icon(Icons.person),
                          border: InputBorder.none
                        ),
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins'
                        )
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        // color: const Color.fromARGB(255, 247, 248, 248),
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.deepPurple.shade200)
                      ),
                      child: FormBuilderTextField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.name,
                        name: 'lName',
                        validator: FormBuilderValidators.required(),
                        controller: _lNameController,
                        decoration: InputDecoration(
                            labelText: "LastName",
                            floatingLabelStyle: TextStyle(
                              color: Colors.deepPurple.shade900,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins'
                            ),
                            prefixIcon: const Icon(Icons.person_outline),
                            border: InputBorder.none
                        ),
                        style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins'
                        )
                      ),
                    ),
                    const SizedBox(height: 10),
                    Visibility(
                      visible: offerService,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              // color: const Color.fromARGB(255, 247, 248, 248),
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.deepPurple.shade200)
                            ),
                            child: FormBuilderTextField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.multiline,
                              name: 'description',
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                              ]),
                              controller: _descriptionController,
                              decoration:  InputDecoration(
                                  labelText: "Description",
                                  floatingLabelStyle: TextStyle(
                                      color: Colors.deepPurple.shade900,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Poppins'
                                  ),
                                  prefixIcon: const Icon(Icons.description),
                                  border: InputBorder.none
                              ),
                              textInputAction: TextInputAction.newline,
                              style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins'
                              )
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              // color: const Color.fromARGB(255, 247, 248, 248),
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.deepPurple.shade200)
                            ),
                            child: FormBuilderTextField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.multiline,
                              name: 'hourlyRate',
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                                FormBuilderValidators.numeric(),
                              ]),
                              controller: _hourlyRateController,
                              decoration:  InputDecoration(
                                  labelText: "Hourly Rate",
                                  floatingLabelStyle: TextStyle(
                                      color: Colors.deepPurple.shade900,
                                      fontWeight: FontWeight.w500,
                                    fontFamily: 'Poppins'
                                  ),
                                  prefixText: "UGX ",
                                  prefixIcon: const Icon(Icons.monetization_on),
                                  border: InputBorder.none
                              ),
                              style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins'
                              )
                            ),
                          ),
                          const SizedBox(height: 10)
                        ])),
                    Container(
                      decoration: BoxDecoration(
                        // color: const Color.fromARGB(255, 247, 248, 248),
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.deepPurple.shade200)
                      ),
                      child: FormBuilderTextField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.multiline,
                        name: 'phone',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.numeric(),
                        ]),
                        controller: _phoneController,
                        decoration:  InputDecoration(
                            labelText: "Phone",
                            floatingLabelStyle: TextStyle(
                                color: Colors.deepPurple.shade900,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins'
                            ),
                            prefixIcon: const Icon(Icons.phone),
                            border: InputBorder.none
                        ),
                        style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins'
                        )
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        // color: const Color.fromARGB(255, 247, 248, 248),
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.deepPurple.shade200)
                      ),
                      child: FormBuilderTextField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: FormBuilderValidators.required(),
                        keyboardType: TextInputType.streetAddress,
                        name: 'address',
                        controller: _addressController,
                        decoration: InputDecoration(
                            labelText:"Address",
                            floatingLabelStyle: TextStyle(
                              color: Colors.deepPurple.shade900,
                                  fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins'
                            ),
                            prefixIcon: const Icon(Icons.home),
                            border: InputBorder.none
                        ),
                        style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins'
                        )
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
                            backgroundColor: const Color(0xFF755DC1),
                            side: BorderSide.none,
                            shape: const StadiumBorder()),
                        child: const Text("Save",
                            style: TextStyle(color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins'
                            )),
                      ),
                    ),
                    const SizedBox(height: 30),
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