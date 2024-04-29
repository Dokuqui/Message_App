import '../model/message.dart';

class MessageController {
  static final MessageController _instance = MessageController._internal();
  factory MessageController() => _instance;

  MessageController._internal();

  final List<Message> _messages = [];
  int _nextId = 1;

  void addMessage(Message message) {
    message.id = _nextId++;
    _messages.add(message);
  }

  void editMessage(Message message) {
    int index = _messages.indexWhere((msg) => msg.id == message.id);
    if (index != -1) {
      _messages[index] = message;
    }
  }

  void deleteMessage(Message message) {
    _messages.removeWhere((msg) => msg.id == message.id);
  }

  List<Message> getAllMessages() {
    return List.of(_messages);
  }
}