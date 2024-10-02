import 'package:chat_app/Cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/Models/Messge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Helper/ShowSnakBar.dart';
import '../Widgets/ChatBuble.dart';
import '../constans.dart';

// ignore: must_be_immutable
class ChatPage extends StatelessWidget {
  static String id = 'ChatPage';
  String? message = "";
  String? mail;

  TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();
  List<Message> messagesList = [];
  ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    mail = ModalRoute.of(context)!.settings.arguments as String?;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              kLogo,
              height: 50,
            ),
            const Text('Chat')
          ],
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatCubit, ChatState>(
              listener: (context, state) {
                if (state is ChatSuccess) {
                  messagesList = state.messageList;
                }
              },
              builder: (context, state) {
                return ListView.builder(
                  reverse: true,
                  controller: scrollController,
                  physics: const BouncingScrollPhysics(),
                  itemCount: messagesList.length,
                  itemBuilder: (context, index) {
                    return messagesList[index].id == mail
                        ? ChatBubble(
                            message: messagesList[index],
                          )
                        : ChatBubbleForFriend(
                            message: messagesList[index],
                          );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: controller,
              onChanged: (value) {
                message = value;
              },
              onSubmitted: (value) {
                if (value != "") {
                  BlocProvider.of<ChatCubit>(context)
                      .sendMessage(message: value, email: mail!);
                  controller.clear();
                  _scrollDown();
                  message = "";
                } else {
                  ShowSnakBar(context, 'Please Enter Message');
                }
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: kPrimaryColor)),
                suffixIcon: GestureDetector(
                  onTap: () {
                    if (message != "") {
                      BlocProvider.of<ChatCubit>(context)
                          .sendMessage(message: message!, email: mail!);
                      controller.clear();
                      _scrollDown();
                      message = "";
                    } else {
                      ShowSnakBar(context, 'Please Enter Message');
                    }
                  },
                  child: Icon(
                    Icons.send,
                    color: kPrimaryColor,
                  ),
                ),
                hintText: 'Send Message',
              ),
            ),
          )
        ],
      ),
    );
  }

  void _scrollDown() {
    scrollController.animateTo(
      0,
      duration: Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }
}
