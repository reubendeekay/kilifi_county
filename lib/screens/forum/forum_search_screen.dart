import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kilifi_county/providers/post_provider.dart';
import 'package:kilifi_county/providers/user_provider.dart';
import 'package:kilifi_county/screens/forum/widgets/forum_picture_tile.dart';
import 'package:kilifi_county/screens/forum/widgets/forum_text_tile.dart';

class ForumSearchScreen extends StatefulWidget {
  static const routeName = '/forum-search-screen';

  @override
  _ForumSearchScreenState createState() => _ForumSearchScreenState();
}

class _ForumSearchScreenState extends State<ForumSearchScreen> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: SizedBox(
            height: 45,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: searchController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search a user\'s posts',
                      suffixIcon: Icon(Icons.search)),
                  onChanged: (val) {
                    setState(() {});
                  },
                ),
              ),
            ),
          ),
          automaticallyImplyLeading: false,
        ),
        body: searchController.text.isNotEmpty
            ? StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('posts')
                    .where('fullName',
                        isGreaterThanOrEqualTo:
                            toBeginningOfSentenceCase(searchController.text))
                    .where('fullName',
                        isLessThan: toBeginningOfSentenceCase(
                            searchController.text + 'z'))
                    .snapshots(),
                builder: (ctx, snapshot) {
                  if (!snapshot.hasData ||
                      snapshot.hasError ||
                      snapshot.data == null) {
                    return Container();
                  } else {
                    print(searchController.text);
                    List<DocumentSnapshot> documents = snapshot.data.docs;

                    List<Widget> forum = [];
                    documents.forEach((e) {
                      if (e['imageUrl'] != null) {
                        forum.add(ForumPictureTile(Post(
                            comments: e['comments'],
                            description: e['description'],
                            id: e['postId'],
                            imageUrl: e['imageUrl'],
                            likes: e['likes'],
                            user: UserModel(
                                fullName: e['fullName'],
                                imageUrl: e['profilePic'],
                                username: e['username'],
                                userId: e['userId'],
                                isVerified: e['isVerified']))));
                      } else {
                        forum.add(ForumTextTile(Post(
                            comments: e['comments'],
                            description: e['description'],
                            id: e['postId'],
                            likes: e['likes'],
                            user: UserModel(
                                fullName: e['fullName'],
                                imageUrl: e['profilePic'],
                                username: e['username'],
                                userId: e['userId'],
                                isVerified: e['isVerified']))));
                      }
                    });

                    return ListView(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: forum);
                  }
                },
              )
            : Container());
  }
}
