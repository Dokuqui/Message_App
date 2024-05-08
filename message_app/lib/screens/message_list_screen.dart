import 'package:flutter/material.dart';
import '../controller/message_controller.dart';
import '../model/message.dart';
import 'message_detail_screen.dart';

class MessageListScreen extends StatelessWidget {
  final List<Message> messages;
  final void Function(Message) onDeleteMessage;

  const MessageListScreen(
      {required this.messages, required this.onDeleteMessage});

  @override
  Widget build(BuildContext context) {
    final MessageController _messageController = MessageController();

    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Message List', style: TextStyle(color: Colors.white)),
        elevation: 10.0,
        centerTitle: true,
      ),
      body: messages.isEmpty
          ? const Center(
              child: Text('No messages', style: TextStyle(color: Colors.white)),
            )
          : ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                Message message = messages[index];
                return Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    _messageController.deleteMessage(message);
                    onDeleteMessage(message);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Message ${message.subject} dismissed'),
                      ),
                    );
                  },
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: Card(
                    elevation: 2,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.message),
                      title: Text(
                        message.subject,
                        style: const TextStyle(fontSize: 20),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MessageDetailScreen(message: message),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
