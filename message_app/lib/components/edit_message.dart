import 'package:flutter/material.dart';
import '../controller/message_controller.dart';
import '../model/message.dart';

class EditMessageScreen extends StatefulWidget {
  final Message message;

  const EditMessageScreen({Key? key, required this.message}) : super(key: key);

  @override
  _EditMessageScreenState createState() => _EditMessageScreenState();
}

class _EditMessageScreenState extends State<EditMessageScreen> {
  late TextEditingController _subjectController;
  late TextEditingController _contentController;

  MessageController _messageController = MessageController();

  @override
  void initState() {
    super.initState();
    _subjectController = TextEditingController(text: widget.message.subject);
    _contentController = TextEditingController(text: widget.message.content);
  }

  void _submitMessage() {
    if (_subjectController.text.isNotEmpty && _contentController.text.isNotEmpty) {
      Message editedMessage = Message(
        id: widget.message.id,
        subject: _subjectController.text,
        content: _contentController.text,
        sendDate: widget.message.sendDate,
        author: widget.message.author,
      );

      _messageController.editMessage(editedMessage);

      Navigator.of(context).pop(editedMessage);
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
        title: const Text('Edit Message', style: TextStyle(color: Colors.white)),
        elevation: 10.0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Edit Message Form',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _subjectController,
              decoration: const InputDecoration(
                labelText: 'Subject',
                border: OutlineInputBorder(),
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
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
