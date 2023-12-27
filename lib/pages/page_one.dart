// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:myapp/data%20folder/get_data.dart';
import 'package:flutter/material.dart';

class PageOne extends StatefulWidget {
  const PageOne({super.key});

  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  List<String> docsList = [];

  @override
  void initState() {
    super.initState();
    readStore();
  }

  Future<void> readStore() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
            .instance
            .collection('user')
            .where('email', isEqualTo: user.email)
            .orderBy('age', descending: true)
            .get();

        setState(() {
          docsList = snapshot.docs.map((doc) => doc.id).toList();
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error reading data from Firestore: $e');
      }
      // Handle the error (show a snackbar, log the error, etc.)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${FirebaseAuth.instance.currentUser?.email ?? ''} "),
        actions: [
          GestureDetector(
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
            child: const Icon(Icons.logout),
          ),
        ],
      ),
      body: docsList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: docsList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: GetData(documentId: docsList[index]),
              tileColor: Colors.amber[100],
            ),
          );
        },
      ),
    );
  }
}