import 'package:flutter/material.dart';
import 'package:message_app/screens/user_detail_screen.dart';
import '../controller/message_controller.dart';
import '../controller/user_controller.dart';
import '../model/message.dart';
import '../model/user.dart';
import 'message_list_screen.dart';


class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreen();
  }
}

class _HomeScreen extends State<UserListScreen> {
  final UserController _userController = UserController();
  final MessageController _messageController = MessageController();

  @override
  void initState() {
    super.initState();
    _userController.fetchUsers().then((users) {
      for (var user in users) {
        _userController.addUser(user);
      }
      print('Users: ${_userController.users}');
    }).catchError((error) {
      print('Error fetching users: $error');
    });
  }

  Widget _buildUserList() {
    return ListView.builder(
      itemCount: _userController.users.length,
      itemBuilder: (BuildContext context, int index) {
        User user = _userController.users[index];
        return Dismissible(
          key: Key(user.id.toString()),
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
                        builder: (context) =>
                            UserDetailScreen(
                                user: user),
                      ));
                }
              },
            ),
          ),
        );
      },
    );
  }


  void _deleteMessage(Message message) {
    _messageController.deleteMessage(message);
    setState(() {});
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
                  builder: (context) =>
                      MessageListScreen(
                        messages: _messageController.getAllMessages(),
                        onDeleteMessage: _deleteMessage,
                      ),
                ),
              );
            },
          )
        ],
      ),
      body: _buildUserList(),
    );
  }
}
