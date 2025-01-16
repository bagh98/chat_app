import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/constants.dart';
import '../model/message.dart';
import '../widgets/chat_buble.dart';
import 'cubits/chat_cubit/chat_cubit.dart';

class HomePage extends StatelessWidget {
  final _controller = ScrollController();

  List<Message> messagesList = [];

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              KLogo,
              height: 50,
            ),
            const Text(' Chat'),
          ],
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: KPrimaryColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                var messagesList =
                    BlocProvider.of<ChatCubit>(context).messagesList;
                return ListView.builder(
                  reverse: true,
                  controller: _controller,
                  itemCount: messagesList.length,
                  itemBuilder: (context, index) =>
                      messagesList[index].id == email
                          ? chatBuble(
                              message: messagesList[index],
                            )
                          : chatBubleForFriend(message: messagesList[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: controller,
              onSubmitted: (data) {
                BlocProvider.of<ChatCubit>(context).sendMessage(
                  message: data,
                  email: email.toString(),
                );
                controller.clear();
                _controller.animateTo(
                  0,
                  duration: const Duration(seconds: 1),
                  curve: Curves.fastOutSlowIn,
                );
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: KPrimaryColor),
                  borderRadius: BorderRadius.circular(16),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: KPrimaryColor),
                  borderRadius: BorderRadius.circular(16),
                ),
                hintText: 'Send a message',
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.send,
                    color: KPrimaryColor,
                  ),
                  onPressed: () {
                    BlocProvider.of<ChatCubit>(context).sendMessage(
                      message: controller.text,
                      email: email.toString(),
                    );
                    controller.clear();
                    _controller.animateTo(
                      0,
                      duration: const Duration(seconds: 1),
                      curve: Curves.fastOutSlowIn,
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
