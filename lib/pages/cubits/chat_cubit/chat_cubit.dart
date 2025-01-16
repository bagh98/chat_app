import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../../constants/constants.dart';
import '../../../model/message.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  CollectionReference messages =
      FirebaseFirestore.instance.collection(KMessagesCollection);
  List<Message> messagesList = [];

  void sendMessage({required String message, required String email}) {
    try {
      messages.add({
        KMessage: message,
        KCreatedAt: DateTime.now(),
        'id': email,
      });
    } on Exception catch (e) {
      emit(CatFailure());
    }
  }

  void getMessages() {
    messages.orderBy(KCreatedAt, descending: true).snapshots().listen((event) {
      messagesList.clear();
      for (var doc in event.docs) {
        messagesList.add(Message.fromJson(doc));
      }
      emit(CatSuccess(
        messages: messagesList,
      ));
    });
  }
}
