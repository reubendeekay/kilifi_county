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
          child: Padding(
              padding: EdgeInsets.fromLTRB(10, 8, 15, 2),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 12),
                    constraints: BoxConstraints(maxWidth: (size.width / 1.3)),
                    child: Text(
                      message.message,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: -9,
                    child: Text(
                      '11:30',
                      textAlign: TextAlign.end,
                      style:
                          TextStyle(fontSize: 9, fontWeight: FontWeight.w300),
                    ),
                  )
                ],
              )),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(13),
                  bottomLeft: uid == message.userId
                      ? Radius.circular(13)
                      : Radius.circular(0),
                  topRight: Radius.circular(13),
                  bottomRight: uid == message.userId
                      ? Radius.circular(0)
                      : Radius.circular(13)),
              color: kPrimary),
        ),
      ],
    );
  }
}
