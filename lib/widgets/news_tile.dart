import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kilifi_county/constants.dart';
import 'package:kilifi_county/loaders/color_loader.dart';
import 'package:kilifi_county/loaders/my_loader.dart';
import 'package:kilifi_county/models/news_model.dart';
import 'package:kilifi_county/screens/home/news_details.dart';

class NewsTile extends StatelessWidget {
  final String index;
  final String fullName;
  final List<dynamic> images;
  final String profilePic;
  final String title;
  final String article;
  final int views;
  final String username;
  final String postId;
  final Timestamp date;

  const NewsTile(
      {this.index,
      this.fullName,
      this.images,
      this.profilePic,
      this.title,
      this.article,
      this.views,
      this.username,
      this.postId,
      this.date});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(NewsDetailsScreen.routeName,
          arguments: NewsModel(
              article: article,
              fullName: fullName,
              images: images,
              profilePic: profilePic,
              title: title,
              views: views,
              postId: postId,
              username: username,
              date: DateFormat('dd/MM/yyyy').format(date.toDate()))),
      child: Container(
        margin: EdgeInsets.fromLTRB(15, 0, 15, 5),
        height: 82,
        width: double.infinity,
        child: Row(
          children: [
            Container(
              height: double.infinity,
              width: 100,
              child: ShaderMask(
                shaderCallback: (rect) {
                  return LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.black,
                      Colors.black,
                      Colors.black,
                      Colors.transparent
                    ],
                  ).createShader(
                      Rect.fromLTRB(0, rect.top, rect.width, rect.bottom));
                },
                blendMode: BlendMode.dstIn,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
                  child: Image.network(
                    images.first,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SizedBox(),
                ),
                Container(
                  width: size.width - 150,
                  constraints: BoxConstraints(maxHeight: 57),
                  margin: EdgeInsets.only(top: 5, bottom: 5, right: 5),
                  child: Text(
                    title,
                    softWrap: true,
                    overflow: TextOverflow.fade,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ),
                Spacer(),
                Container(
                  margin: EdgeInsets.fromLTRB(2, 0, 2, 2),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 6,
                        backgroundImage: NetworkImage(profilePic),
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Text(
                        fullName,
                        style: TextStyle(color: Colors.grey, fontSize: 11),
                      ),
                      Container(
                        width: size.width * 0.3,
                        alignment: Alignment.bottomRight,
                        child: Text(
                          DateFormat.jm().format(date.toDate()),
                          style: TextStyle(color: Colors.grey, fontSize: 11),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class News extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('admin')
            .doc('admin_data')
            .collection('news')
            .orderBy('createdAt')
            .snapshots(),
        builder: (ctx, snapshots) {
          if (snapshots.hasData && !snapshots.hasError) {
            List<DocumentSnapshot> documents = snapshots.data.docs;

            return ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: documents
                  .map((e) => NewsTile(
                        article: e['article'],
                        index: '1',
                        title: e['title'],
                        date: e['createdAt'],
                        views: e['views'],
                        images: e['images'],
                        username: e['username'],
                        fullName: e['fullName'],
                        profilePic: e['profilePic'],
                        postId: e['postId'],
                      ))
                  .toList(),
            );
          } else {
            return Center(
              child: MyLoader(),
            );
          }
        });
  }
}
