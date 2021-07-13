import 'package:flutter/material.dart';
import 'package:kilifi_county/models/post_models.dart';
import 'package:kilifi_county/providers/dark_mode_provider.dart';
import 'package:provider/provider.dart';

class CommentTile extends StatefulWidget {
  final Comments comment;
  CommentTile(this.comment);

  @override
  _CommentTileState createState() => _CommentTileState();
}

class _CommentTileState extends State<CommentTile> {
  bool _isLiked = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final dark = Provider.of<DarkThemeProvider>(context).darkTheme;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                  widget.comment.imageUrl,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: size.width - 70,
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: '@${widget.comment.username} ',
                            style: TextStyle(
                                color: dark ? Colors.white : Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          TextSpan(
                            text: widget.comment.description,
                            style: TextStyle(
                              color: dark ? Colors.white : Colors.black,
                            ),
                          )
                        ]),
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 0.5,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              _isLiked = !_isLiked;
                            });
                          },
                          child: _isLiked
                              ? Icon(
                                  Icons.favorite_border,
                                  size: 13,
                                )
                              : Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                  size: 13,
                                )),
                      SizedBox(
                        width: 5,
                      ),
                      if (widget.comment.likes > 0)
                        Text(
                          widget.comment.likes == 1
                              ? '${widget.comment.likes.toStringAsFixed(0)} like'
                              : '${widget.comment.likes.toStringAsFixed(0)} likes',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w600),
                        )
                    ],
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
