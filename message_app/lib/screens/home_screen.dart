import 'package:flutter/material.dart';
import 'package:message_app/screens/user_detail_user.dart';
import '../controller/user_controller.dart';
import '../model/user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreen();
  }
}

class _HomeScreen extends State<HomeScreen> {
  UserController _userController = UserController();

  /*
  @override
  void initState() {
    super.initState();
    _userController.loadUsers();
  }
   */

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
            title: const Text('Ajouter un utilisateur'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: 'Prénom'),
                  onChanged: (value) {
                    firstName = value;
                  },
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Nom'),
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
                child: const Text('Abort'),
              ),
              ElevatedButton(
                onPressed: () {
                  _addUser(firstName, lastName);
                },
                child: const Text('Ajouter'),
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
      ),
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: _buildUserList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddUserDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
