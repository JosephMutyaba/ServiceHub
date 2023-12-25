// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetask/data%20folder/get_data.dart';
import 'package:flutter/material.dart';

class PageOne extends StatefulWidget {
  const PageOne({super.key});

  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  List<String> docsList = [];

  Future readStore() async {
    await FirebaseFirestore.instance
        .collection('user').where('age',isGreaterThan: 24)
        .orderBy('age', descending: true)
        .get()
        // ignore: avoid_function_literals_in_foreach_calls
        .then((snapShot) => snapShot.docs.forEach((element) {
              docsList.add(element.reference.id);
            }));
  }

  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${user.email!} "),
        actions: [
          GestureDetector(
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
            child: Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // MaterialButton(
            //   onPressed: () {

            //   },
            //   color: Colors.deepPurple,
            //   child: const Text(
            //     "Sign Out",
            //     style: TextStyle(
            //       color: Colors.white,
            //       fontSize: 15,
            //     ),
            //   ),
            // ),
            Expanded(
              child: FutureBuilder(
                future: readStore(),
                builder: (context, snapShot) {
                  return ListView.builder(
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
