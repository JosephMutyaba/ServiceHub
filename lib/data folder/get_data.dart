import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetData extends StatelessWidget {
  final String documentId;
  const GetData({super.key, required this.documentId});

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('user');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder: (context, snapShot) {
        if (snapShot.connectionState == ConnectionState.waiting) {
          return const Text("loading...");
        } else if (snapShot.hasError) {
          return Text("Error: ${snapShot.error}");
        } else if (snapShot.hasData && snapShot.data != null) {
          Map<String, dynamic> data = snapShot.data!.data() as Map<String, dynamic>;
          return Text('${data['fname']} ${data['lName']}, ${data['age']} years old');
        } else {
          return const Text("No data available");
        }
      },
    );
  }
}
