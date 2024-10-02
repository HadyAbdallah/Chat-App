import 'package:bloc/bloc.dart';
import 'package:chat_app/Models/Messge.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../constans.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollection);

  void sendMessage({required String message, required String email}) {
    messages.add({kMessage: message, kcreatedAt: DateTime.now(), 'id': email});
  }

  void getMessage() {
    messages.orderBy(kcreatedAt, descending: true).snapshots().listen((event) {
      List<Message> messagesList = [];
      for (var doc in event.docs) {
        messagesList.add(Message.fromJson(doc));
      }
      emit(ChatSuccess(messageList: messagesList));
    });
  }
}
