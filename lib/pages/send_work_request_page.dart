
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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

  Future<void> sendWorkRequest() async {
    Map<String, dynamic>? userData = await load();

    if (userData != null) {
      // Access userData here and perform your actions
      if (userData['role'] == 'common_user') {
        // Validate and send the work request
        final String description = descriptionController.text.trim();
        final double budget = double.tryParse(budgetController.text.trim()) ?? 0;

        if (description.isNotEmpty && budget > 0) {
          requestList.add({'description': description, 'budget': budget});
          // Pass the request data to the Cart screen
          if(!mounted) return;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Cart(
                requestList: requestList,
              ),
            ),
          );

          // Notify the professional about the work request
          notifyProfessional(description, budget);

          // Show a success message to the user
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
      } else {
        if (!mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProvidersCart()),
        );
      }
    } else {
      if (kDebugMode) {
        print("User data is not available");
      }
    }
  }


  Future<void> notifyProfessional(String description, double budget) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'work_request_channel',
      'Work Requests',
      channelDescription: 'Channel for receiving work requests',
      importance: Importance.max,
      priority: Priority.high,
    );
    // const IOSNotificationDetails iOSPlatformChannelSpecifics =
    //     IOSNotificationDetails();
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      // iOS: iOSPlatformChannelSpecifics,
    );

    // Show a local notification to simulate notifying the professional
    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      'New Work Request',
      'Work request - $description, Budget - UGX $budget',
      platformChannelSpecifics,
      payload: 'item x', // Optional, you can use this to identify the notification
    );
  }
}
