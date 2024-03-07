import 'package:bloc/bloc.dart';
import 'package:chat_app_bloc/constants.dart';
import 'package:chat_app_bloc/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollections);

  sendMessage({required String message, required String email}) {
    messages.add(
      {kMessage: message, kCreatedAt: DateTime.now(), 'id': email},
    );
  }

  getMessages() {
    messages.orderBy(kCreatedAt, descending: true).snapshots().listen((event) {
      List<Message> messagesList = [];
      for (var doc in event.docs) {
        messagesList.add(Message.fromJson(doc));
      }
      emit(ChatSuccess(messages: messagesList));
    });
  }
}
