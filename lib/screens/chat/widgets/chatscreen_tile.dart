import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kilifi_county/constants.dart';
import 'package:kilifi_county/models/chat_model.dart';

class ChatscreenTile extends StatelessWidget {
  final Message message;
  ChatscreenTile(this.message);
  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser.uid;
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: uid == message.userId
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 2.5),
          constraints: BoxConstraints(maxWidth: (size.width / 2) + 20),
          child:
              Padding(padding: EdgeInsets.all(7), child: Text(message.message)),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: uid == message.userId
                      ? Radius.circular(15)
                      : Radius.circular(0),
                  topRight: Radius.circular(15),
                  bottomRight: uid == message.userId
                      ? Radius.circular(0)
                      : Radius.circular(15)),
              color: kPrimary),
        ),
      ],
    );
  }
}
