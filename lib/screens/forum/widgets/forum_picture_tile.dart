import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kilifi_county/constants.dart';
import 'package:kilifi_county/providers/dark_mode_provider.dart';
import 'package:kilifi_county/providers/post_provider.dart';
import 'package:kilifi_county/screens/forum/comments_screen.dart';
import 'package:kilifi_county/widgets/small%20widgets/like_widget.dart';
import 'package:provider/provider.dart';

class ForumPictureTile extends StatefulWidget {
  final Post post;
  ForumPictureTile(this.post);
  @override
  _ForumPictureTileState createState() => _ForumPictureTileState();
}

class _ForumPictureTileState extends State<ForumPictureTile> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final dark = Provider.of<DarkThemeProvider>(context);
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
      ),
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage(widget.post.user.imageUrl),
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
                          widget.post.user.fullName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        if (widget.post.user.isVerified)
                          Icon(
                            Icons.verified,
                            color: Colors.blue,
                            size: 14,
                          ),
                      ],
                    ),
                    Text(
                      '@${widget.post.user.username}',
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.grey,
                          fontSize: 13),
                    )
                  ],
                ),
              ),
              Spacer(),
              SizedBox(
                  height: 30,
                  child:
                      IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)))
            ],
          ),
          Container(
            height: size.width,
            margin: EdgeInsets.only(top: 5, left: 2),
            width: double.infinity,
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  widget.post.imageUrl,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: 38,
            child: Row(
              children: [
                SizedBox(
                    width: 35,
                    child: LikeWidget(
                      post: widget.post,
                      size: 26,
                      tweet: false,
                    )),
                IconButton(
                    onPressed: () async {
                      await Navigator.of(context).pushNamed(
                          CommentsScreen.routeName,
                          arguments: widget.post);
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.comment,
                      size: 22,
                    )),
                Spacer(),
                IconButton(
                    onPressed: () {},
                    icon: FaIcon(
                      FontAwesomeIcons.bell,
                      size: 22,
                    ))
              ],
            ),
          ),
          if (widget.post.likes.isNotEmpty)
            AnimatedContainer(
              duration: Duration(milliseconds: 200),
              curve: Curves.fastOutSlowIn,
              margin: EdgeInsets.symmetric(horizontal: 10),
              width: (size.width) - 40,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 100,
                    height: 40,
                    child: Stack(
                      children: [
                        Positioned(
                            left: 0,
                            child: CircleAvatar(
                                radius: 14,
                                backgroundImage: NetworkImage(
                                  widget.post.likes[0]['images'],
                                ))),
                        if (widget.post.likes.length > 1)
                          Positioned(
                              left: 12,
                              child: CircleAvatar(
                                  radius: 14,
                                  backgroundImage: NetworkImage(
                                    widget.post.likes[1]['images'],
                                  ))),
                        if (widget.post.likes.length > 2)
                          Positioned(
                              left: 24,
                              child: CircleAvatar(
                                  radius: 14,
                                  backgroundImage: NetworkImage(
                                    widget.post.likes[2]['images'],
                                  ))),
                        if (widget.post.likes.length > 3)
                          Positioned(
                              left: 36,
                              child: CircleAvatar(
                                  radius: 14,
                                  backgroundImage: NetworkImage(
                                    widget.post.likes[3]['images'],
                                  ))),
                        if (widget.post.likes.length > 4)
                          Positioned(
                              left: 48,
                              child: CircleAvatar(
                                  radius: 14,
                                  backgroundImage: NetworkImage(
                                    widget.post.likes[4]['images'],
                                  ))),
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    margin: EdgeInsets.only(top: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.post.likes.last['usernames'],
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        if (widget.post.likes.length > 1)
                          Text(
                            ' and ',
                            style: TextStyle(fontSize: 14),
                          ),
                        Text(
                          widget.post.likes.length > 1
                              ? '${widget.post.likes.length} others'
                              : ' liked this',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(shape: BoxShape.rectangle),
            margin: EdgeInsets.only(left: 10),
            width: double.infinity,
            child: RichText(
                text: TextSpan(
                    text: '${widget.post.user.username} ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: dark.darkTheme ? Colors.white : Colors.black),
                    children: <TextSpan>[
                  TextSpan(
                    text: widget.post.description,
                    style: TextStyle(
                        color: dark.darkTheme ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w400),
                  )
                ])),
          ),
          SizedBox(
            height: 3,
          ),
          if (widget.post.comments.length > 0)
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: GestureDetector(
                onTap: () => Navigator.of(context).pushNamed(
                    CommentsScreen.routeName,
                    arguments: widget.post),
                child: Text(
                  'View comments',
                  style:
                      TextStyle(color: kPrimary, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          Divider()
        ],
      ),
    );
  }
}
