// professional_inbox_page.dart

import 'package:flutter/material.dart';
import 'work_request.dart';

class ProfessionalInboxPage extends StatefulWidget {
  @override
  _ProfessionalInboxPageState createState() => _ProfessionalInboxPageState();
}

class _ProfessionalInboxPageState extends State<ProfessionalInboxPage> {
  final List<WorkRequest> workRequests = []; // Professional's inbox

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inbox'),
      ),
      body: ListView.builder(
        itemCount: workRequests.length,
        itemBuilder: (context, index) {
          final WorkRequest request = workRequests[index];
          return ListTile(
            title: Text(request.description),
            subtitle: Text('Budget: \$${request.budget}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () {
                    // Step 6: Approve the work request
                    approveWorkRequest(request);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    // Step 7: Reject the work request
                    rejectWorkRequest(request);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void approveWorkRequest(WorkRequest request) {
    // TODO: Implement approval logic
    // In a real app, you might update the status of the work request in Firestore
    // and send a notification to the user who initiated the request.
    // For simplicity, remove the request from the inbox for now.
    setState(() {
      workRequests.remove(request);
    });
  }

  void rejectWorkRequest(WorkRequest request) {
    // TODO: Implement rejection logic
    // In a real app, you might update the status of the work request in Firestore
    // and send a notification to the user who initiated the request.
    // For simplicity, remove the request from the inbox for now.
    setState(() {
      workRequests.remove(request);
    });
  }
}
