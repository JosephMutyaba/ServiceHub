import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:myapp/messaging/chat/chat_service.dart';

class ChatPage extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserId;
  const ChatPage({
    super.key,
    required this.receiverUserEmail,
    required this.receiverUserId,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //sendMessage
  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendmessage(
          widget.receiverUserId, _messageController.text.trim());
      // clear the controller after sending the message
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 122, 124, 122),
      appBar: AppBar(
        title: Text(widget.receiverUserEmail),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            //messages
            Expanded(
              child: _buildMessageList(),
            ),
      
            //user input
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  //build message list
  Widget _buildMessageList() {
    return StreamBuilder(
        stream: _chatService.getMessages(
            widget.receiverUserId, _firebaseAuth.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading..');
          }

          return ListView(
            reverse: true,
            children: snapshot.data!.docs
                .map((document) => _buildMessageItem(document))
                .toList(),
          );
        });
  }


  


  //build message item
  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    // message alignment
    var alignment = (data['senderId']) == _firebaseAuth.currentUser!.uid
        ? Alignment.bottomRight
        : Alignment.centerLeft;

    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(      
        alignment: alignment,
        child: Column(
          crossAxisAlignment:
              (data['senderId'] == _firebaseAuth.currentUser!.uid)
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
          children: [
            //Text(data['senderEmail']),
            Container(
              decoration: BoxDecoration(
                color: (data['senderId'] == _firebaseAuth.currentUser!.uid)
                    ? const Color.fromARGB(255, 5, 113, 202)
                    : Colors.green,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  data['message'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //build message input
  Widget _buildMessageInput() {
    return Row(
      children: [
        //text field
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 247, 248, 248),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: _messageController,
                decoration: const InputDecoration(
                  hintText: 'type message...',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
        //icon button
        Container(
          decoration: BoxDecoration(color: Colors.green[900],
          borderRadius: BorderRadius.circular(10),
          ),
          child: IconButton(
            onPressed: sendMessage,
            icon: const Icon(
              Icons.send,
              size: 30,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
