import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kilifi_county/constants.dart';
import 'package:kilifi_county/providers/post_provider.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';

class SavePostWidget extends StatelessWidget {
  final Post post;
  final double size;

  SavePostWidget({
    this.post,
    this.size,
  });
  Future<bool> getPost() async {
    final uid = FirebaseAuth.instance.currentUser.uid;
    final get = await FirebaseFirestore.instance
        .collection('userData')
        .doc('savedPosts')
        .collection(uid)
        .doc(post.id)
        .get();
    if (get.exists) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
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
            await onLikeButtonTapped(await getPost(), context, post));
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
