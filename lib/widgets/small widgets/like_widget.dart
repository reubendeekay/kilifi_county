import 'package:flutter/material.dart';
import 'package:kilifi_county/models/post_models.dart';
import 'package:kilifi_county/providers/post_provider.dart';
import 'package:kilifi_county/providers/user_provider.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';

class LikeWidget extends StatelessWidget {
  final Post post;
  final double size;
  final bool tweet;
  LikeWidget({this.post, this.size, this.tweet});
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UsersProvider>(context, listen: false).user;

    var isLiked = post.likes.any((element) => element['userId'] == user.userId);
    return LikeButton(
        size: size,
        isLiked: isLiked,
        likeBuilder: (isLiked) {
          return tweet
              ? Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border,
                  color: isLiked ? Colors.red : Colors.grey,
                  size: size,
                )
              : Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border,
                  color:
                      isLiked ? Colors.red : Theme.of(context).iconTheme.color,
                  size: size,
                );
        },
        likeCount: tweet ? post.likes.length : null,
        onTap: (isLiked) async =>
            await onLikeButtonTapped(isLiked, context, post));
  }
}

Future<bool> onLikeButtonTapped(
    bool isLiked, BuildContext context, Post post) async {
  /// send your request here
  // final bool success= await sendRequest();
  final user = Provider.of<UsersProvider>(context, listen: false).user;
  var success;
  List<dynamic> like = [];
  like.add(Likes(
      id: user.userId,
      usersProfilesLiked: user.imageUrl,
      usersUsernamesLiked: user.username));
  try {
    await Provider.of<PostProvider>(context, listen: false)
        .like(post, like, isLiked);
    success = true;
  } catch (error) {
    success = false;
    print(error);
  }

  /// if failed, you can do nothing
  return success ? !isLiked : isLiked;
}
