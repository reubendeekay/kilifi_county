import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashed_circle/dashed_circle.dart';
import 'package:flutter/material.dart';
import 'package:kilifi_county/models/post_models.dart';
import 'package:kilifi_county/widgets/stories.dart';

class PosterTile extends StatefulWidget {
  final String description;
  final String fullName;
  final String username;
  final String imageUrl;
  final List<dynamic> postPics;
  final String userId;
  final String postId;

  const PosterTile(
      {this.description,
      this.fullName,
      this.username,
      this.imageUrl,
      this.postPics,
      this.userId,
      this.postId});
  @override
  _PosterTileState createState() => _PosterTileState();
}

class _PosterTileState extends State<PosterTile>
    with SingleTickerProviderStateMixin {
  Animation gap;
  Animation<double> base;
  Animation<double> reverse;
  AnimationController controller;

  /// Init
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 4));
    base = CurvedAnimation(parent: controller, curve: Curves.easeOut);
    reverse = Tween<double>(begin: 0.0, end: -1.0).animate(base);
    gap = Tween<double>(begin: 3.0, end: 0.0).animate(base)
      ..addListener(() {
        setState(() {});
      });
    controller.forward();
  }

  /// Dispose
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(StoriesPage.routeName,
          arguments: StoryModel(
            description: widget.description,
            fullName: widget.fullName,
            username: widget.username,
            imageUrl: widget.imageUrl,
            postId: widget.postId,
            postPics: widget.postPics,
            userId: widget.userId,
          )),
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 8, bottom: 10, top: 2),
        child: RotationTransition(
          turns: base,
          child: DashedCircle(
            gapSize: gap.value,
            dashes: 30,
            color: Colors.deepOrange,
            child: RotationTransition(
              turns: reverse,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: CircleAvatar(
                  radius: 25.0,
                  backgroundImage: NetworkImage(widget.postPics.last),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Stories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('admin')
              .doc('admin_data')
              .collection('posters')
              .orderBy('createdAt')
              .limit(15)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData && !snapshot.hasError) {
              List<DocumentSnapshot> documents = snapshot.data.docs;
              return SingleChildScrollView(
                child: Row(
                  children: documents
                      .map((e) => PosterTile(
                            username: e['username'],
                            userId: e['userId'],
                            imageUrl: e['imageUrl'],
                            postPics: e['postPics'],
                            postId: e['postId'],
                            fullName: e['fullName'],
                            description: e['description'],
                          ))
                      .toList(),
                ),
              );
            } else {
              return Container();
            }
          }),
    );
  }
}

class PosterFullScreen extends StatelessWidget {
  final String description;
  final String fullName;
  final String username;
  final String imageUrl;
  final List<dynamic> postPics;
  final String userId;
  final String postId;

  const PosterFullScreen(
      {this.description,
      this.fullName,
      this.username,
      this.imageUrl,
      this.postPics,
      this.postId,
      this.userId});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          height: 400,
          child: Stack(
            children: [
              AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: ListView.builder(
                    itemBuilder: (ctx, i) => Container(
                      width: size.width - 50,
                      height: size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: NetworkImage(postPics[i]),
                              fit: BoxFit.fill)),
                    ),
                    itemCount: postPics.length,
                  )),
              Positioned(
                  bottom: 0,
                  child: Container(
                    width: size.width - 70,
                    color: Colors.black38,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        description,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )),
              Positioned(
                  left: 5,
                  top: 5,
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(imageUrl),
                        radius: 15,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          fullName,
                          style: TextStyle(
                            color: Colors.white,
                            shadows: [
                              Shadow(color: Colors.grey[800], blurRadius: 5)
                            ],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
