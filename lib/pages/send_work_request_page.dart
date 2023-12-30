

// import 'package:flutter/material.dart';

// class SendWorkRequestPage extends StatefulWidget {
//   final Map<String, dynamic> professionalData;

//   const SendWorkRequestPage({Key? key, required this.professionalData}) : super(key: key);

//   @override
//   _SendWorkRequestPageState createState() => _SendWorkRequestPageState();
// }

// class _SendWorkRequestPageState extends State<SendWorkRequestPage> {
//   final TextEditingController descriptionController = TextEditingController();
//   final TextEditingController budgetController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Send Work Request'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text('Describe the work:'),
//             TextField(controller: descriptionController),
//             const SizedBox(height: 16),
//             const Text('Budget:'),
//             TextField(controller: budgetController),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 // Step 3: Send the work request
//                 sendWorkRequest();
//               },
//               child: const Text('Send Request'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void sendWorkRequest() {
//     // Validate and send the work request
//     final String description = descriptionController.text.trim();
//     final double budget = double.tryParse(budgetController.text.trim()) ?? 0;

//     if (description.isNotEmpty && budget > 0) {
//       // Step 4: Notify the professional about the work request
//       notifyProfessional(description, budget);

//       // Go back to the previous page

//       // Optionally, you can show a success message or navigate to another screen
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: const Text('Work request sent successfully!'),
//         ),
//       );
//       // TODO: Implement navigation to the next page or handle success
//       Navigator.pop(context); 
//     } else {
//       // Show an error message to the user if the input is invalid
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: const Text('Please provide a valid description and budget.'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   void notifyProfessional(String description, double budget) {
//     // TODO: Implement notification logic
//     // In a real app, you might use a push notification service or a messaging system
//     // to notify the professional about the work request.
//     // For simplicity, you can print a message to the console for now.
//     print('Notify professional: Work request - $description, Budget - $budget');
//   }
// }







import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class SendWorkRequestPage extends StatefulWidget {
  final Map<String, dynamic> professionalData;

  const SendWorkRequestPage({Key? key, required this.professionalData}) : super(key: key);

  @override
  _SendWorkRequestPageState createState() => _SendWorkRequestPageState();
}

class _SendWorkRequestPageState extends State<SendWorkRequestPage> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController budgetController = TextEditingController();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();

    // Initialize the local notification plugin
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    // final IOSInitializationSettings initializationSettingsIOS =
    //     IOSInitializationSettings();
    final InitializationSettings initializationSettings =
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

  void sendWorkRequest() {
    // Validate and send the work request
    final String description = descriptionController.text.trim();
    final double budget = double.tryParse(budgetController.text.trim()) ?? 0;

    if (description.isNotEmpty && budget > 0) {
      // Step 4: Notify the professional about the work request
      notifyProfessional(description, budget);

      // TODO: Implement navigation to the next page or handle success
      // Navigator.pop(context); // Go back to the previous page

      // Optionally, you can show a success message or navigate to another screen
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Work request sent successfully!'),
        ),
      );
    } else {
      // Show an error message to the user if the input is invalid
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please provide a valid description and budget.'),
          backgroundColor: Colors.red,
        ),
      );
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
