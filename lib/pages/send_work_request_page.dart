import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:myapp/messaging/chat/chat_service.dart';
import 'package:myapp/messaging/chat_page.dart';


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
        title: Text('Send Work Request',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
              fontSize: 23,
            )
        ),
        backgroundColor: const Color(0xff755dc1),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Describe the work:',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  )
              ),
              TextField(controller: descriptionController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  hintText: 'Enter a description of the work',
                ),
                textInputAction: TextInputAction.newline,
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
      
              ),
              const SizedBox(height: 16),
              const Text('Budget:',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),),
              TextField(controller: budgetController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  prefixText: 'UGX ',
                  hintText: 'Enter your budget',
                ),
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                )
      
      
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Step 3: Send the work request
                   sendWorkRequest();
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color(0xff755dc1),
                  backgroundColor: Colors.deepPurple[50],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
      
                ),
                child: const Text('Send Request',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    )
              ),
              )],
          ),
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
    if(!mounted) return;
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
