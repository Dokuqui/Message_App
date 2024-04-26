import 'package:flutter/material.dart';
import 'package:message_app/model/user.dart';

class UserDetailScreen extends StatelessWidget {
  final User user;

  const UserDetailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Detail', style: TextStyle(color: Colors.white)),
        elevation: 10.0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'First Name: ${user.lastName}',
                style: const TextStyle(fontSize: 18)
            ),
            const SizedBox(height: 10),
            Text(
              'Last Name: ${user.lastName}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10)
          ],
        )
      ),
    );
  }
}