import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:myapp/messaging/chat_page.dart';
import 'package:myapp/utils.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 201, 186, 186),
      appBar: AppBar(
        title: const Text("Users"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
      body: _userList(),
      bottomNavigationBar: bottomNavbar(context),
    );
    
  }

  Widget _userList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("user").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }

        return FutureBuilder<List<DocumentSnapshot>>(
          future: _filterUsers(snapshot.data!.docs),
          builder: (context, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading...");
            }

            return ListView(
              children: userSnapshot.data!
                  .map<Widget>((doc) => _userListItem(doc))
                  .toList(),
            );
          },
        );
      },
    );
  }

  Widget _userListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    Future<void> navigateToChat() async {
      // Check if the user has sent messages to the professional
      bool hasSentMessages = await checkIfMessagesExist(data["uid"]);

      if (hasSentMessages) {
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(
              receiverUserEmail: data["email"],
              receiverUserId: data["uid"],
            ),
          ),
        );
      } else {
        // Handle the case where messages haven't been sent
        // (e.g., show a message to the user)
      }
    }

    return ListTile(
      // title: Text(data["email"]),
      title: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 52, 118, 180),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // Display an image
              CircleAvatar(
                backgroundImage: NetworkImage(data["imageUrl"] ?? ''),
                radius: 29.0,
              ),
              const SizedBox(width: 16),
              // Display the user's name
              Text("${data['fname']} ${data['lName']}",style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),),
            ],
          ),
        ),
      ),
      onTap: navigateToChat,
    );
  }

  Future<List<DocumentSnapshot>> _filterUsers(
    List<DocumentSnapshot> users,
  ) async {
    List<DocumentSnapshot> filteredUsers = [];

    for (var user in users) {
      bool hasMessages = await checkIfMessagesExist(user["uid"]);
      if (hasMessages) {
        filteredUsers.add(user);
      }
    }

    return filteredUsers;
  }

  Future<bool> checkIfMessagesExist(String userId) async {
    List<String> ids = [
      _auth.currentUser!.uid,
      userId,
    ];
    ids.sort();
    String chatRoomId = ids.join("_");

    // Use Firestore to check if there are messages sent or received with the user
    QuerySnapshot<Map<String, dynamic>> messagesSnapshot =
        await FirebaseFirestore.instance
            .collection('user')
            .doc(chatRoomId)
            .collection('messages')
            .get();

    return messagesSnapshot.docs.isNotEmpty;
  }
}
