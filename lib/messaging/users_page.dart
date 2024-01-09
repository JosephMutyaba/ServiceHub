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
      appBar: AppBar(
        title: Text("Chats",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                  fontSize: 23,
            )
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if(!mounted) return;
                Navigator.of(context).popUntil((route) => route.isFirst);
            },
          )
        ],
        backgroundColor: const Color(0xFF755DC1),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: _userList(),
      bottomNavigationBar: bottomNavbar(context,2),
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
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return FutureBuilder<List<DocumentSnapshot>>(
          future: _filterUsers(snapshot.data!.docs),
          builder: (context, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(
              child: CircularProgressIndicator(),
              );
            }

            return ListView(
              children: userSnapshot.data!
                    .map<Widget>((doc) => Container(
              margin: const EdgeInsets.all(3.0),
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: _userListItem(doc),
            )
              ).toList(),
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
       visualDensity: VisualDensity.compact,
        onTap: navigateToChat,
       title: Text("${data['fname']} ${data['lName']}",
         style: const TextStyle(
                     fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                   ),
         selectionColor: Colors.deepPurple[50],
       ),
       leading: CircleAvatar(
                 backgroundImage: NetworkImage(data["imageUrl"] ?? 'assets/images/screens/profile.png'),
                 radius: 30.0,
               ),
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
