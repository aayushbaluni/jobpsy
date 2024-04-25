import 'package:flutter/material.dart';

class User {
  final String name;
  final String email;
  final String image;

  User({required this.name, required this.email, required this.image});
}

class RequestPage extends StatefulWidget {
  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  List<User> users = [
    User(name: 'John Doe', email: 'john@example.com', image: 'assets/user1.jpg'),
    User(name: 'Alice Smith', email: 'alice@example.com', image: 'assets/user2.jpg'),
    User(name: 'Bob Johnson', email: 'bob@example.com', image: 'assets/user3.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(users[index].name),
              onTap: () {
                _showUserDetails(users[index]);
              },
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.check),
                    onPressed: () {
                      _acceptRequest(users[index]);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      _rejectRequest(users[index]);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showUserDetails(User user) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(user.name),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Email: ${user.email}'),
              SizedBox(height: 8),
              Image.asset(user.image),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _acceptRequest(User user) {
    // Handle accepting request logic
    print('Accepted request from ${user.name}');
  }

  void _rejectRequest(User user) {
    // Handle rejecting request logic
    print('Rejected request from ${user.name}');
  }
}