import 'package:flutter/material.dart';
import 'package:message_app/model/user.dart';
import '../components/create_message.dart';
import '../model/message.dart';
import 'message_detail_screen.dart';

class UserDetailScreen extends StatefulWidget {
  final User user;
  final List<Message> messages;
  const UserDetailScreen(
      {super.key, required this.user, required this.messages});

  @override
  _UserDetailScreenState createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
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
              Center(
                child: Text(
                  '${widget.user.firstName} ${widget.user.lastName}',
                  style: const TextStyle(
                    fontSize: 26,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final newMessage = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CreateMessageScreen(user: widget.user),
                    ),
                  );
                  if (newMessage != null && newMessage is Message) {
                    setState(() {
                      widget.messages.add(newMessage);
                    });
                  }
                },
                child: const Text('Create Message',
                    style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 20),
              const Text(
                'Messages',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.messages.length,
                  itemBuilder: (context, index) {
                    Message message = widget.messages[index];
                    return Card(
                      elevation: 2.0,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Dismissible(
                          key: UniqueKey(),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {
                            setState(() {
                              widget.user.messages.removeAt(index);
                            });
                          },
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20.0),
                            color: Colors.red,
                            child:
                                const Icon(Icons.delete, color: Colors.white),
                          ),
                          child: ListTile(
                            leading: const Icon(Icons.message),
                            title: Text(message.subject,
                                style: const TextStyle(fontSize: 20)),
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
                      ),
                    );
                  },
                ),
              )
            ],
          )),
    );
  }
}
