import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:kilifi_county/providers/post_provider.dart';

import 'package:kilifi_county/screens/forum/comments_screen.dart';
import 'package:kilifi_county/widgets/small%20widgets/like_widget.dart';
import 'package:kilifi_county/widgets/small%20widgets/save_post_widget.dart';

class ForumTextTile extends StatelessWidget {
  final Post post;
  ForumTextTile(this.post);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage(post.user.imageUrl),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          post.user.fullName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        if (post.user.isVerified)
                          Icon(
                            Icons.verified,
                            color: Colors.blue,
                            size: 14,
                          ),
                      ],
                    ),
                    Text(
                      '@${post.user.username}',
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.grey,
                          fontSize: 13),
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Text(post.description),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Row(children: [
              GestureDetector(
                onTap: () => Navigator.of(context)
                    .pushNamed(CommentsScreen.routeName, arguments: post),
                child: FaIcon(
                  FontAwesomeIcons.comment,
                  color: Colors.grey,
                  size: 18,
                ),
              ),
              SizedBox(
                width: 7,
              ),
              Text(
                post.comments.length.toStringAsFixed(0),
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(
                width: 40,
              ),
              LikeWidget(
                post: post,
                size: 20,
                tweet: true,
              ),
              Spacer(),
              SavePostWidget(
                post: post,
                size: 18,
              )
            ]),
          ),
          Divider(
            height: 9,
          )
        ],
      ),
    );
  }
}
