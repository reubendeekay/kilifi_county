import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kilifi_county/constants.dart';
import 'package:kilifi_county/models/post_models.dart';
import 'package:kilifi_county/providers/dark_mode_provider.dart';
import 'package:kilifi_county/providers/post_provider.dart';
import 'package:kilifi_county/providers/user_provider.dart';
import 'package:kilifi_county/widgets/netwok_items.dart';
import 'package:provider/provider.dart';

class CommentsScreen extends StatelessWidget {
  static const routeName = '/comments-screen';
  final commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final post = ModalRoute.of(context).settings.arguments as Post;
    final user = Provider.of<UsersProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
      ),
      body: Container(
        height: size.height,
        child: Column(
          children: [
            ownerDescription(context, post),
            Container(child: Expanded(child: GenerateComments(post.id))),
            SizedBox(
              height: 5,
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Container(
                    width: size.width - 55,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: TextField(
                        controller: commentController,
                        decoration: InputDecoration(
                          hintText: 'Share your comment',
                          hintStyle: TextStyle(fontSize: 14),
                          border: InputBorder.none,
                        ),
                        maxLines: null,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      List<dynamic> comment = [];
                      comment.add(Comments(
                          description: commentController.text,
                          imageUrl: user.imageUrl,
                          likes: 0,
                          username: user.username));
                      commentController.clear();

                      await Provider.of<PostProvider>(context, listen: false)
                          .comment(post, comment);
                    },
                    child: Text(
                      'Post',
                      style: TextStyle(color: kPrimary),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget ownerDescription(BuildContext context, Post post) {
    final size = MediaQuery.of(context).size;
    final dark = Provider.of<DarkThemeProvider>(context).darkTheme;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Hero(
                tag: post.id,
                transitionOnUserGestures: true,
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage:
                      CachedNetworkImageProvider(post.user.imageUrl),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                  width: size.width - 70,
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: '@${post.user.username} ',
                        style: TextStyle(
                            color: dark ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                      TextSpan(
                        text: post.description,
                        style: TextStyle(
                          color: dark ? Colors.white : Colors.black,
                        ),
                      )
                    ]),
                  )),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Divider(
            height: 9,
            thickness: 1,
          )
        ],
      ),
    );
  }
}
