import '../constans.dart';

class Message {
  final String data;
  final String id;
  Message(this.data, this.id);
  factory Message.fromJson(jsonData) {
    return Message(jsonData[kMessage], jsonData['id']);
  }
}
