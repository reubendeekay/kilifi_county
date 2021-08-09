import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kilifi_county/constants.dart';
import 'package:kilifi_county/models/chat_model.dart';
import 'package:kilifi_county/providers/user_provider.dart';
import 'package:kilifi_county/screens/chat/widgets/chatscreen_tile.dart';
import 'package:provider/provider.dart';

class Chats extends StatelessWidget {
  final String userId;
  final bool isConsultation;
  Chats({this.isConsultation, this.userId});
  final uid = FirebaseAuth.instance.currentUser.uid;

  @override
  Widget build(BuildContext context) {
    return isConsultation
        ? StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('interactions')
                .doc('chats')
                .collection('messages')
                .doc('consultation')
                .collection(uid)
                .orderBy('createdAt')
                .limit(50)
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
                      .toList(),
                );
              } else {
                return Container();
              }
            },
          )
        : StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('interactions')
                .doc('userChat')
                .collection('users')
                .doc(userId)
                .collection('messages')
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
                      .toList(),
                );
              } else {
                return Container();
              }
            },
          );
  }
}

class AddMessage extends StatefulWidget {
  final bool isConsultation;
  final UserModel toUser;

  AddMessage({this.isConsultation, this.toUser});

  @override
  _AddMessageState createState() => _AddMessageState();
}

class _AddMessageState extends State<AddMessage> {
  final messageController = TextEditingController();

  List<File> fileNames;
  List<Uint8List> files;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UsersProvider>(context).user;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Column(
        children: [
          if (fileNames != null)
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.grey[900],
              ),
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.fromLTRB(30, 15, 15, 15),
              child: Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.filePdf,
                    color: Colors.red,
                    size: 40,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      child: Container(
                    child: Text('${fileNames.first}'),
                  ))
                ],
              ),
            ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: messageController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Container(
                    margin: EdgeInsets.only(right: 10),
                    child: GestureDetector(
                      onTap: () async {
                        await getFile();
                      },
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
                        sendMessage(message, user);
                      },
                      child: Text('Send')),
                  suffixStyle:
                      TextStyle(color: kPrimary, fontWeight: FontWeight.w500)),
              maxLines: null,
            ),
          ),
        ],
      ),
    );
  }

  void sendMessage(String message, UserModel user) async {
    final uid = FirebaseAuth.instance.currentUser.uid;
    if (widget.isConsultation) {
      await FirebaseFirestore.instance
          .collection('interactions')
          .doc('chats')
          .collection('messages')
          .doc(widget.isConsultation ? 'consultation' : 'customerCare')
          .collection(uid)
          .doc()
          .set({
        'message': message,
        'userId': uid,
        'createdAt': Timestamp.now(),
        'status': 'delivered'
      });

      await FirebaseFirestore.instance
          .collection('interactions')
          .doc('chats')
          .collection(widget.isConsultation ? 'users' : 'userCare')
          .doc(user.userId)
          .set({
        'userId': user.userId,
        'email': user.email,
        'username': user.username,
        'imageUrl': user.imageUrl,
        'fullName': user.fullName,
        'nationalId': user.nationalId,
        'phoneNumber': user.phoneNumber,
        'subCounty': user.subCounty,
        'isVerified': user.isVerified,
        'accessedAt': Timestamp.now(),
        'latestMessage': message,
      }, SetOptions(merge: true));
    } else {
      await FirebaseFirestore.instance
          .collection('interactions')
          .doc('userChat')
          .collection('users')
          .doc(widget.toUser.userId)
          .collection('messages')
          .doc()
          .set({
        'message': message,
        'userId': uid,
        'createdAt': Timestamp.now(),
        'status': 'delivered'
      });

      await FirebaseFirestore.instance
          .collection('interactions')
          .doc('userChat')
          .collection('users')
          .doc(widget.toUser.userId)
          .collection('users')
          .doc(user.userId)
          .set({
        'userId': user.userId,
        'email': user.email,
        'username': user.username,
        'imageUrl': user.imageUrl,
        'fullName': user.fullName,
        'nationalId': user.nationalId,
        'phoneNumber': user.phoneNumber,
        'subCounty': user.subCounty,
        'isVerified': user.isVerified,
        'accessedAt': Timestamp.now(),
        'latestMessage': message,
      }, SetOptions(merge: true));

      await FirebaseFirestore.instance
          .collection('interactions')
          .doc('userChat')
          .collection('users')
          .doc(user.userId)
          .collection('users')
          .doc(widget.toUser.userId)
          .set({
        'userId': widget.toUser.userId,
        'email': widget.toUser.email,
        'username': widget.toUser.username,
        'imageUrl': widget.toUser.imageUrl,
        'fullName': widget.toUser.fullName,
        'nationalId': widget.toUser.nationalId,
        'phoneNumber': widget.toUser.phoneNumber,
        'subCounty': widget.toUser.subCounty,
        'isVerified': widget.toUser.isVerified,
        'accessedAt': Timestamp.now(),
        'latestMessage': message,
      }, SetOptions(merge: true));
    }
  }

  Future<void> getFile() async {
    FilePickerResult result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      fileNames = result.names.map((path) => File(path)).toList();
      result.files.forEach((element) {
        files.add(element.bytes);
      });
      setState(() {});
    } else {
      // User canceled the picker
    }
  }
}
