// user_inbox_page.dart

import 'package:flutter/material.dart';
import 'work_request.dart';

class UserInboxPage extends StatelessWidget {
  final List<WorkRequest> approvedRequests; // User's inbox

  const UserInboxPage({Key? key, required this.approvedRequests})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inbox'),
      ),
      body: ListView.builder(
        itemCount: approvedRequests.length,
        itemBuilder: (context, index) {
          final WorkRequest request = approvedRequests[index];
          return ListTile(
            title: Text(request.description),
            subtitle: Text('Budget: \$${request.budget}'),
            // TODO: Display contact details and location
          );
        },
      ),
    );
  }
}
