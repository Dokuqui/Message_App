import 'message.dart';

class User {
  int? id;
  String _firstName;
  String _lastName;
  String _email;
  List<Message> _messages;

  User.create(int id, String firstName, String lastName, String email, [List<Message>? messages])
      : id = id,
        _firstName = firstName,
        _lastName = lastName,
        _email = email,
        _messages = messages ?? [];

  String get firstName => _firstName;
  String get lastName => _lastName;
  String get email => _email;
  List<Message> get messages => _messages;

  set firstName(String value) {
    if (value.isNotEmpty) {
      _firstName = value;
    }
  }

  set lastName(String value) {
    if (value.isNotEmpty) {
      _lastName = value;
    }
  }

  set email(String value) {
    if (value.isNotEmpty) {
      _email = value;
    }
  }

  factory User.fromJson(Map<String, dynamic> json) {
    List<Message> messages = [];
    if (json['messages'] != null) {
      json['messages'].forEach((messageJson) {
        messages.add(Message.fromJson(messageJson));
      });
    }

    return User.create(
      json['id'],
      json['firstName'],
      json['lastName'],
      json['email'],
      messages,
    );
  }
}
