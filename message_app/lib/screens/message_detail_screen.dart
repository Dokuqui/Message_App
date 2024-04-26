import 'package:flutter/material.dart';

import '../model/message.dart';

class MessageDetailScreen extends StatelessWidget {
  final Message message;

  const MessageDetailScreen({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Message Detail', style: TextStyle(color: Colors.white)),
        elevation: 10.0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Subject:\n ${message.subject}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Content:\n ${message.content}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Date:\n ${message.sendDate}',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Author:\n ${message.author.firstName} ${message.author.lastName}',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}