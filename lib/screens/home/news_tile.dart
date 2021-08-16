import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kilifi_county/constants.dart';
import 'package:kilifi_county/loaders/color_loader.dart';
import 'package:kilifi_county/loaders/my_loader.dart';
import 'package:kilifi_county/models/news_model.dart';
import 'package:kilifi_county/models/post_models.dart';
import 'package:kilifi_county/screens/home/news_details.dart';

class NewsTile extends StatelessWidget {
  final String index;
  final String fullName;
  final String images;
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
      onTap: () {
        Navigator.of(context).pushNamed(NewsDetailsScreen.routeName,
            arguments: NewsModel(
                article: article,
                fullName: fullName,
                imageUrl: images,
                profilePic: profilePic,
                title: title,
                views: views,
                postId: postId,
                username: username,
                date: DateFormat('dd/MM/yyyy').format(date.toDate())));
        FirebaseFirestore.instance
            .collection('admin')
            .doc('admin_data')
            .collection('news')
            .doc(postId)
            .update({
          'views': views + 1,
        });
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(15, 0, 15, 10),
        height: 85,
        width: double.infinity,
        child: Row(
          children: [
            Hero(
              tag: postId,
              transitionOnUserGestures: true,
              child: Container(
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
                        topLeft: Radius.circular(5),
                        bottomLeft: Radius.circular(5)),
                    child: cachedImage(
                      url: images,
                      fit: BoxFit.fill,
                    ),
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
                        backgroundImage: CachedNetworkImageProvider(profilePic),
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
