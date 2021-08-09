import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kilifi_county/constants.dart';
import 'package:kilifi_county/providers/post_provider.dart';
import 'package:kilifi_county/providers/user_provider.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';

class SavePostWidget extends StatelessWidget {
  final Post post;
  final double size;

  SavePostWidget({
    this.post,
    this.size,
  });
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UsersProvider>(context, listen: false).user;

    return LikeButton(
        size: size,
        likeBuilder: (isLiked) {
          return FaIcon(
            isLiked
                ? FontAwesomeIcons.solidBookmark
                : FontAwesomeIcons.bookmark,
            color: isLiked ? kPrimary : Colors.grey,
            size: size,
          );
        },
        likeCount: null,
        onTap: (isLiked) async =>
            await onLikeButtonTapped(isLiked, context, post));
  }
}

Future<bool> onLikeButtonTapped(
    bool isLiked, BuildContext context, Post post) async {
  /// send your request here
  // final bool success= await sendRequest();

  var success;

  try {
    await Provider.of<PostProvider>(context, listen: false)
        .savePost(post, isLiked);
    success = true;
  } catch (error) {
    success = false;
    print(error);
  }

  /// if failed, you can do nothing
  return success ? !isLiked : isLiked;
}
