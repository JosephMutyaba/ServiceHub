import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  UserCredential? _userCredential; // Instance variable to store UserCredential

  // Getter to access the UserCredential from outside the class
  UserCredential? get userCredential => _userCredential;

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      _userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firebaseFirestore
          .collection('user')
          .doc(_userCredential!.user!.uid)
          .set({
        'uid': _userCredential!.user!.uid,
        'email': email,
      }, SetOptions(merge: true));

      return _userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<User?> signUpWithEmailAndPassword(
    String password,
    String email,
  ) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Retrieve the user
      User? user = userCredential.user;

      return user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future addUser(
    User user,
    String fname,
    String lName,
    String email,
    String phone,
    String address,
    String imageUrl,
    String profession,
    String description,
    bool serviceType,
    int hourlyRate,
    int likes,
    int rating,
  ) async {
    await _firebaseFirestore.collection('user').doc(user.uid).set(
      {
        'uid': user.uid,
        'fname': fname,
        'lName': lName,
        'email': email,
        'phone': phone,
        'address': address,
        'imageUrl': imageUrl,
        'profession': profession,
        'description': description,
        'offer_servive': serviceType,
        'hourlyRate': hourlyRate,
        'likes': likes,
        'rating': rating,
      },
    );
  }
}
