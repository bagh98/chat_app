import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../model/message.dart';
import '../widgets/chat_buble.dart';

class HomePage extends StatelessWidget {
  final _controller = ScrollController();

  CollectionReference messages =
      FirebaseFirestore.instance.collection(KMessagesCollection);

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy(KCreatedAt, descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Message> messagesList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
            }
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
                    child: ListView.builder(
                      reverse: true,
                      controller: _controller,
                      itemCount: messagesList.length,
                      itemBuilder: (context, index) => messagesList[index].id ==
                              email
                          ? chatBuble(
                              message: messagesList[index],
                            )
                          : chatBubleForFriend(message: messagesList[index]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: controller,
                      onSubmitted: (data) {
                        messages.add({
                          KMessage: data,
                          KCreatedAt: DateTime.now(),
                          'id': email,
                        });
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
                            messages.add({
                              KMessage: controller.text,
                              KCreatedAt: DateTime.now(),
                              'id': email,
                            });
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
          } else {
            return const Text('loading');
          }
        });
  }
}
