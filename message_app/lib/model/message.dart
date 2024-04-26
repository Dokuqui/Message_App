import 'package:message_app/model/user.dart';

class Message {
  int id;
  final String subject;
  final String content;
  final DateTime sendDate;
  final User author;

  Message({
    required this.id,
    required this.subject,
    required this.content,
    required this.sendDate,
    required this.author,
  });
}
