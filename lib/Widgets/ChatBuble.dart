import 'package:chat_app/Models/Messge.dart';
import 'package:flutter/material.dart';

import '../constans.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.message});
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.only(left: 16, top: 25, bottom: 25, right: 16),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(36),
              topLeft: Radius.circular(36),
              bottomRight: Radius.circular(36)),
        ),
        child: Text(
          message.data,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class ChatBubbleForFriend extends StatelessWidget {
  const ChatBubbleForFriend({super.key, required this.message});
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.only(left: 16, top: 25, bottom: 25, right: 16),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Color(0xFF006D84),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(36),
              topLeft: Radius.circular(36),
              bottomLeft: Radius.circular(36)),
        ),
        child: Text(
          message.data,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
