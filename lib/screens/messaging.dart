import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/auth/auth_page.dart';
import 'package:myapp/screens/cart.dart';
import 'package:myapp/utils.dart';

import 'profile.dart';

class ChatRoute extends StatefulWidget {
  const ChatRoute({super.key});

  @override
  State<ChatRoute> createState() => _ChatRouteState();
}

class _ChatRouteState extends State<ChatRoute> {
  bool showSend = false;
  final TextEditingController controller = TextEditingController();
  List<Message> messages = [];
  late ChatRouteAdapter adapter;

  @override
  void initState() {
    super.initState();
    messages.add(Message.time(
        messages.length,
        "Hello!",
        true,
        messages.length % 5 == 0,
        getFormattedTimeEvent(DateTime.now().millisecondsSinceEpoch)));
    messages.add(Message.time(
        messages.length,
        "Hai..",
        false,
        messages.length % 5 == 0,
        getFormattedTimeEvent(DateTime.now().millisecondsSinceEpoch)));
  }

  @override
  Widget build(BuildContext context) {
    adapter = ChatRouteAdapter(context, messages, onItemClick);
       double baseWidth = 414;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Messages',
          style: safeGoogleFont(
            'SF Pro Display',
            fontSize: 34 * ffem,
            fontWeight: FontWeight.w700,
            height: 1.2058823529 * ffem / fem,
            letterSpacing: 0.4099999964 * fem,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        actions: [
          GestureDetector(
            onTap: () {
              FirebaseAuth.instance.signOut();
              // ignore: use_build_context_synchronously
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const AuthPage(),
                ),
              );
            },
            child: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: adapter.getView(),
            ),
            const Divider(height: 0, thickness: 1),
            Row(
              children: <Widget>[
                Container(width: 10),
                Expanded(
                  child: TextField(
                    controller: controller,
                    maxLines: 1,
                    minLines: 1,
                    keyboardType: TextInputType.multiline,
                    decoration: new InputDecoration.collapsed(
                        hintText: 'Write a message...'),
                    onChanged: (term) {
                      setState(() {
                        showSend = (term.length > 0);
                      });
                    },
                  ),
                ),
                IconButton(
                    icon: Icon(Icons.sentiment_satisfied,
                        color: Colors.grey, size: 20),
                    onPressed: () {}),
                IconButton(
                    icon: Icon(Icons.send, color: Colors.grey, size: 20),
                    onPressed: () {
                      if (showSend) sendMessage();
                    }),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                    icon: const Icon(Icons.crop_original,
                        color: Colors.grey, size: 20),
                    onPressed: () {}),
                IconButton(
                    icon: const Icon(Icons.my_location,
                        color: Colors.grey, size: 20),
                    onPressed: () {}),
                IconButton(
                    icon: const Icon(Icons.photo_camera,
                        color: Colors.grey, size: 20),
                    onPressed: () {}),
                IconButton(
                    icon: const Icon(Icons.insert_drive_file,
                        color: Colors.grey, size: 20),
                    onPressed: () {}),
                IconButton(
                    icon: const Icon(Icons.arrow_forward_ios,
                        color: Colors.grey, size: 20),
                    onPressed: () {}),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.deepPurple),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, color: Colors.deepPurple),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.deepPurple),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail, color: Colors.deepPurple),
            label: 'Chat',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.deepPurple,
        onTap: (index) {
          if (index == 0) {
            Navigator.of(context).popUntil((route) => route.isFirst);
          } else if (index == 1) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const Cart()));
          } else if (index == 2) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ProfilePage()));
          } else if (index == 3) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ChatRoute()));
          }
        },
      ),
    );
  }

  void onItemClick(int index, String obj) {}

  void sendMessage() {
    String message = controller.text;
    controller.clear();
    showSend = false;
    setState(() {
      adapter.insertSingleItem(Message.time(
          adapter.getItemCount(),
          message,
          true,
          adapter.getItemCount() % 5 == 0,
          getFormattedTimeEvent(DateTime.now().millisecondsSinceEpoch)));
    });
    generateReply(message);
  }

  void generateReply(String msg) {
    Timer(const Duration(seconds: 1), () {
      setState(() {
        adapter.insertSingleItem(Message.time(
            adapter.getItemCount(),
            msg,
            false,
            adapter.getItemCount() % 5 == 0,
            getFormattedTimeEvent(DateTime.now().millisecondsSinceEpoch)));
      });
    });
  }
}

String getFormattedTimeEvent(int time) {
  DateFormat newFormat = new DateFormat("h:mm a");
  return newFormat.format(new DateTime.fromMillisecondsSinceEpoch(time));
}

TextStyle? medium(BuildContext context) {
  return Theme.of(context).textTheme.subtitle1?.copyWith(
        fontSize: 18,
      );
}

TextStyle? body1(BuildContext context) {
  return Theme.of(context)
      .textTheme
      .bodyText1; // Correct the name to 'bodyText1'
}
