import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kilifi_county/constants.dart';
import 'package:kilifi_county/models/chat_model.dart';
import 'package:kilifi_county/screens/chat/widgets/chatscreen_tile.dart';

class Chats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('interactions')
          .doc('chats')
          .collection('messages')
          .doc('wKI29l5eL7eera3q2pNehuI6cl53')
          .collection('YBWnosfrhUYA1f4Pkld8PR96zS23')
          .orderBy('createdAt')
          .snapshots(),
      builder: (ctx, snapshot) {
        if (snapshot.hasData) {
          List<DocumentSnapshot> documents = snapshot.data.docs;

          return ListView(
              children: documents
                  .map((e) => ChatscreenTile(Message(
                      message: e['message'],
                      time: e['createdAt'],
                      userId: e['userId'],
                      status: e['status'])))
                  .toList());
        } else {
          return Container();
        }
      },
    );
  }
}

class AddMessage extends StatelessWidget {
  final messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: TextField(
          controller: messageController,
          decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Container(
                margin: EdgeInsets.only(right: 10),
                child: GestureDetector(
                  onTap: getFile,
                  child: CircleAvatar(
                    backgroundColor: kPrimary,
                    radius: 12,
                    child: Icon(
                      Icons.attachment_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              prefixIconConstraints:
                  BoxConstraints(minWidth: 42, minHeight: 42),
              suffix: GestureDetector(
                  onTap: () async {
                    String message = messageController.text;
                    messageController.clear();
                    sendMessage(
                      message,
                      'wKI29l5eL7eera3q2pNehuI6cl53',
                    );
                  },
                  child: Text('Post')),
              suffixStyle:
                  TextStyle(color: kPrimary, fontWeight: FontWeight.w500)),
          maxLines: null,
        ),
      ),
    );
  }

  void sendMessage(
    String message,
    String userId,
  ) async {
    final uid = FirebaseAuth.instance.currentUser.uid;

    await FirebaseFirestore.instance
        .collection('interactions')
        .doc('chats')
        .collection('messages')
        .doc(userId)
        .collection(uid)
        .doc()
        .set({
      'message': message,
      'userId': uid,
      'createdAt': Timestamp.now(),
      'status': 'delivered'
    });
  }

  void getFile() async {
    FilePickerResult result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path)).toList();
    } else {
      // User canceled the picker
    }
  }
}
