import 'package:flutter/material.dart';
import 'package:message_app/screens/user_detail_screen.dart';
import '../controller/message_controller.dart';
import '../controller/user_controller.dart';
import '../model/user.dart';
import 'message_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreen();
  }
}

class _HomeScreen extends State<HomeScreen> {
  final UserController _userController = UserController();
  final MessageController _messageController = MessageController();

  void _addUser(String firstName, String lastName) {
    User user = User(firstName, lastName);
    _userController.users.add(user);
    setState(() {});
    Navigator.of(context).pop();
  }

  Future<void> _showAddUserDialog() async {
    String firstName = "";
    String lastName = "";

    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Add new User'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: 'First Name'),
                  onChanged: (value) {
                    firstName = value;
                  },
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Last Name'),
                  onChanged: (value) {
                    lastName = value;
                  },
                )
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  _addUser(firstName, lastName);
                },
                child: const Text('Add'),
              )
            ],
          );
        });
  }

  Widget _buildUserList() {
    return ListView.builder(
      itemCount: _userController.users.length,
      itemBuilder: (BuildContext context, int index) {
        User user = _userController.users[index];
        return Dismissible(
          key: Key(user.lastName ?? UniqueKey().toString()),
          direction: DismissDirection.startToEnd,
          onDismissed: (direction) {
            _userController.users.removeAt(index);
            setState(() {});
          },
          background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              child: const Icon(Icons.delete, color: Colors.white)),
          child: Card(
          child: ListTile(
            leading: const Icon(Icons.person),
            title: Text('${user.firstName ?? ''} ${user.lastName ?? ''}'),
            onTap: () {
              if (user != null) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserDetailScreen(user: user),
                    )
                );
              }
            },
          ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List', style: TextStyle(color: Colors.white)),
        elevation: 10.0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.message_rounded, color: Colors.white),
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MessageListScreen(messages: _messageController.getAllMessages()),
                ),
              );
            },
          )
        ],
      ),
      backgroundColor: Colors.amber,
      body: _buildUserList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddUserDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
