import 'package:flutter/cupertino.dart';

import '../model/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserController extends ChangeNotifier {
  final List<User> _users = [];
  List<User> get users => _users;

  void addUser(User user) {
    _users.add(user);
    notifyListeners();
  }

  void removeUser(User user) {
    _users.remove(user);
    notifyListeners();
  }

  Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse('https://s3-5002.nuage-peda.fr/users'));
    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      final List<dynamic> usersJson = jsonBody;
      return usersJson.map((userJson) => User.fromJson(userJson)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}


