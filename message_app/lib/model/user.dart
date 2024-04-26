import 'message.dart';

class User {
  String _firstName;
  String _lastName;
  List<Message> _messages;

  User(this._firstName, this._lastName, [List<Message>? messages])
      : _messages = messages ?? [];

  String get firstName => _firstName;
  String get lastName => _lastName;
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
}
