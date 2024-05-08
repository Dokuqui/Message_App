import 'package:flutter/material.dart';
import 'package:message_app/components/edit_message.dart';

import '../model/message.dart';

class MessageDetailScreen extends StatefulWidget {
  final Message message;

  const MessageDetailScreen({super.key, required this.message});

  @override
  _MessageDetailScreenState createState() => _MessageDetailScreenState();
}

class _MessageDetailScreenState extends State<MessageDetailScreen> {
  Message? _updatedMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Message Detail', style: TextStyle(color: Colors.white)),
        elevation: 10.0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: () async {
              final updatedMessage = await Navigator.push<Message>(
                context,
                MaterialPageRoute(
                  builder: (context) => EditMessageScreen(message: widget.message),
                ),
              );
              if (updatedMessage != null) {
                setState(() {
                  _updatedMessage = updatedMessage;
                });
              }
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Subject:\n',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              _updatedMessage?.subject ?? widget.message.subject,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            const Text(
              'Content:\n',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              _updatedMessage?.content ?? widget.message.content,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            const Text(
              'Date:\n',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              '${_updatedMessage?.sendDate ?? widget.message.sendDate}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            const Text(
              'Author:\n',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              '${_updatedMessage?.author.firstName ?? widget.message.author.firstName} ${_updatedMessage?.author.lastName ?? widget.message.author.lastName}',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
