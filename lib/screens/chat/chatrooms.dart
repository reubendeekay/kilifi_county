import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kilifi_county/screens/chat/widgets/chatroom_tile.dart';

class ChatRooms extends StatefulWidget {
  static const routeName = '/chatrooms';

  @override
  _ChatRoomsState createState() => _ChatRoomsState();
}

class _ChatRoomsState extends State<ChatRooms> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final uid = FirebaseAuth.instance.currentUser.uid;
    return Scaffold(
      appBar: AppBar(
        title: Text('Connect'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(
                height: 45,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: EdgeInsets.only(left: 1),
                    child: TextField(
                      controller: searchController,
                      onChanged: (val) {
                        setState(() {});
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search',
                          prefixIcon: Icon(
                            Icons.search,
                            size: 20,
                          )),
                    ),
                  ),
                ),
              ),
              if (searchController.text.isEmpty)
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('interactions')
                        .doc('userChat')
                        .collection('users')
                        .doc(uid)
                        .collection('users')
                        .snapshots(),
                    builder: (ctx, snapshot) {
                      if (snapshot.hasData && !snapshot.hasError) {
                        List<DocumentSnapshot> documents = snapshot.data.docs;
                        return Expanded(
                          child: ListView(
                            children: documents
                                .map((e) => ChatroomTile(
                                    date: e['accessedAt'],
                                    latestMessage: e['latestMessage'],
                                    fullName: e['fullName'],
                                    imageUrl: e['imageUrl'],
                                    username: e['username'],
                                    email: e['email'],
                                    isVerified: e['isVerified'],
                                    nationalId: e['nationalId'],
                                    phoneNumber: e['phoneNumber'],
                                    subCounty: e['subCounty'],
                                    userId: e['userId']))
                                .toList(),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    }),
              if (searchController.text.isNotEmpty)
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .where('fullName',
                            isGreaterThanOrEqualTo: toBeginningOfSentenceCase(
                                searchController.text))
                        .where('fullName',
                            isLessThan: toBeginningOfSentenceCase(
                                searchController.text + 'z'))
                        .snapshots(),
                    builder: (ctx, snapshot) {
                      if (snapshot.hasData && !snapshot.hasError) {
                        List<DocumentSnapshot> documents = snapshot.data.docs;
                        return Expanded(
                          child: ListView(
                            children: documents
                                .map((e) => ChatroomTile(
                                    subCounty: e['subCounty'],
                                    email: e['email'],
                                    isVerified: e['isVerified'],
                                    phoneNumber: e['phoneNumber'],
                                    nationalId: e['nationalId'],
                                    fullName: e['fullName'],
                                    imageUrl: e['imageUrl'],
                                    username: e['username'],
                                    userId: e['userId']))
                                .toList(),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    })
            ],
          ),
        ),
      ),
    );
  }
}
