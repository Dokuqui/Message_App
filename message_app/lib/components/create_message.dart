import 'package:flutter/material.dart';
import '../controller/message_controller.dart';
import '../model/message.dart';
import '../model/user.dart';

class CreateMessageScreen extends StatefulWidget {
  final User user;

  const CreateMessageScreen({super.key, required this.user});

  @override
  _CreateMessageScreenState createState() => _CreateMessageScreenState();
}

class _CreateMessageScreenState extends State<CreateMessageScreen> {
  late TextEditingController _subjectController;
  late TextEditingController _contentController;

  MessageController _messageController = MessageController();

  @override
  void initState() {
    super.initState();
    _subjectController = TextEditingController();
    _contentController = TextEditingController();
  }

  void _submitMessage() {
    if (_subjectController.text.isNotEmpty && _contentController.text.isNotEmpty) {
      Message newMessage = Message(
        id: DateTime.now().millisecondsSinceEpoch,
        subject: _subjectController.text,
        content: _contentController.text,
        sendDate: DateTime.now(),
        author: widget.user,
      );

      _messageController.addMessage(newMessage);

      Navigator.of(context).pop(newMessage);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Subject and content cannot be empty!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Message for ${widget.user.firstName} ${widget.user.lastName}',
            style: const TextStyle(color: Colors.white)),
        elevation: 10.0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Create Message Form',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _subjectController,
              decoration: const InputDecoration(
                labelText: 'Subject',
                border: OutlineInputBorder()
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _contentController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Content',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitMessage,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}