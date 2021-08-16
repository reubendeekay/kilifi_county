import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kilifi_county/constants.dart';
import 'package:kilifi_county/providers/user_provider.dart';
import 'package:kilifi_county/screens/chat/chatrooms.dart';
import 'package:kilifi_county/screens/home/news_tile.dart';
import 'package:kilifi_county/screens/userchat/rooms.dart';
import 'package:kilifi_county/widgets/poster_tile.dart';
import 'package:provider/provider.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

class Homepage extends StatelessWidget {
  final _appBarController = ScrollController();
  final uid = FirebaseAuth.instance.currentUser.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScrollAppBar(
        controller: _appBarController,
        title: Row(
          children: [
            Text(
              'Kilifi ',
              style: TextStyle(fontWeight: FontWeight.bold, color: kSecondary),
            ),
            Text(
              'News',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(RoomsPage.routeName);
                },
                icon: FaIcon(FontAwesomeIcons.paperPlane)),
          )
        ],
      ),
      body: Snap(
        controller: _appBarController.appBar,
        child: SafeArea(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData && !snapshot.hasError) {
                  var data = snapshot.data;

                  Provider.of<UsersProvider>(context, listen: false).getUser(
                      UserModel(
                          email: data['email'],
                          isAdmin: data['isAdmin'],
                          office: data['office'],
                          fullName: data['fullName'],
                          imageUrl: data['imageUrl'],
                          nationalId: data['nationalId'],
                          phoneNumber: data['phoneNumber'],
                          subCounty: data['subCounty'],
                          userId: data['userId'],
                          username: data['username'],
                          isVerified: data['isVerified']));
                }
                return ListView(
                  controller: _appBarController,
                  children: [
                    Stories(),
                    Divider(
                      height: 0.1,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    News(),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
