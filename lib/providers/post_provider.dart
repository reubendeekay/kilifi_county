import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:kilifi_county/providers/user_provider.dart';

class Post {
  final UserModel user;
  final String imageUrl;
  final File imageFile;
  List likes;
  final String description;
  final String id;
  List comments;

  Post(
      {this.user,
      this.imageUrl,
      this.imageFile,
      this.description,
      this.id,
      this.likes,
      this.comments});

  Map<String, dynamic> commentsToJson() {
    return {
      'comments': comments.map((e) => e.toJson()),
    };
  }

  Map<String, dynamic> likesToJson() {
    return {
      'likes': likes.map((e) => e.toJson()),
    };
  }
}

class PostProvider with ChangeNotifier {
  List<Post> _posts = [];

  List<Post> get posts {
    return [..._posts];
  }

  Future<void> addPost(Post post, BuildContext context) async {
    final id = await FirebaseFirestore.instance
        .collection('forum')
        .doc('posts')
        .collection(post.user.userId)
        .doc()
        .get();

    var url;
    if (post.imageFile != null) {
      final _imageUrl = await FirebaseStorage.instance
          .ref('forum/posts/${id.id}')
          .putFile(post.imageFile);
      url = await _imageUrl.ref.getDownloadURL();
    }

    await FirebaseFirestore.instance.collection('posts').doc(id.id).set({
      'userId': post.user.userId,
      'fullName': post.user.fullName,
      'username': post.user.username,
      'profilePic': post.user.imageUrl,
      'imageUrl': post.imageFile != null ? url : null,
      'postId': id.id,
      'description': post.description,
      'comments': [],
      'isVerified': post.user.isVerified,
      'likes': [],
      'createdAt': Timestamp.now(),
    }, SetOptions(merge: true));

    _posts.add(post);
    print(_posts[0].description);
  }

  Future<void> comment(Post post, List<dynamic> comment) async {
    final userComment = comment.map((e) => e.toJson()).toList();

    await FirebaseFirestore.instance.collection('posts').doc(post.id).update(
      {
        'comments': FieldValue.arrayUnion(userComment),
      },
    );
  }

  Future<void> like(Post post, List<dynamic> like, bool isLiked) async {
    final userLike = like.map((e) => e.toJson()).toList();

    await FirebaseFirestore.instance.collection('posts').doc(post.id).update(
      {
        'likes': isLiked == false
            ? FieldValue.arrayUnion(userLike)
            : FieldValue.arrayRemove(userLike),
      },
    );
  }
}
