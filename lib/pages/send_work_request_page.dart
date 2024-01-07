import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:myapp/messaging/chat/chat_service.dart';
import 'package:myapp/messaging/chat_page.dart';

import '../screens/cart.dart';
import '../screens/providersCart.dart';
import '../utils.dart';

class SendWorkRequestPage extends StatefulWidget {
  final Map<String, dynamic> professionalData;

  const SendWorkRequestPage({super.key, required this.professionalData});

  @override
  _SendWorkRequestPageState createState() => _SendWorkRequestPageState();
}

class _SendWorkRequestPageState extends State<SendWorkRequestPage> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController budgetController = TextEditingController();
  List<Map<String, dynamic>> requestList = [];


  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();

    // Initialize the local notification plugin
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    // final IOSInitializationSettings initializationSettingsIOS =
    //     IOSInitializationSettings();
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid, );  //iOS: initializationSettingsIOS

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Work Request'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Describe the work:'),
            TextField(controller: descriptionController),
            const SizedBox(height: 16),
            const Text('Budget:'),
            TextField(controller: budgetController),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Step 3: Send the work request
                 sendWorkRequest();
              },
              child: const Text('Send Request'),
            ),
          ],
        ),
      ),
    );
  }

  
void sendWorkRequest() async {
  final String description = descriptionController.text.trim();
  final double budget = double.tryParse(budgetController.text.trim()) ?? 0;

  if (description.isNotEmpty && budget > 0) {
    // Notify the professional about the work request
    await notifyProfessional(description, budget);

    // Navigate to the ChatPage
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ChatPage(
          receiverUserEmail: widget.professionalData['email'],
          receiverUserId: widget.professionalData['uid'],
        ),
      ),
    );

    // Optionally, you can show a success message or handle success
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Work request sent successfully!'),
        dismissDirection: DismissDirection.up,
        backgroundColor: Colors.green,
      ),
    );
  } else {
    // Show an error message to the user if the input is invalid
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please provide a valid description and budget.'),
        backgroundColor: Colors.red,
        dismissDirection: DismissDirection.up,
      ),
    );
  }
}

Future<void> notifyProfessional(String description, double budget) async {
  // Send the description and budget as a chat message
  final ChatService chatService = ChatService();
  await chatService.sendmessage(
    widget.professionalData['uid'],
    'Work request - $description, Budget - UGX $budget',
  );
}

}
