import 'package:chat_app/model/message.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';

class chatBuble extends StatelessWidget {
  final Message message;
  const chatBuble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.only(
          left: 16,
          top: 32,
          bottom: 32,
          right: 32,
        ),
        decoration: BoxDecoration(
          color: KPrimaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        child: Text(
          message.message,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class chatBubleForFriend extends StatelessWidget {
  final Message message;
  const chatBubleForFriend({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.only(
          left: 16,
          top: 32,
          bottom: 32,
          right: 32,
        ),
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
          ),
        ),
        child: Text(
          message.message,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
