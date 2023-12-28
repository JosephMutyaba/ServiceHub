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
      builder: ((context, snapShot) {
        Map<String, dynamic> data =
            snapShot.data!.data() as Map<String, dynamic>;
        if (snapShot.connectionState == ConnectionState.done) {
          return Text('${data['fname']} ${data['lName']}, ${data['age']} years old');
        }
        return const Text("loading...");
      }),
    );
  }
}
