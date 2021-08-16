import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kilifi_county/loaders/my_loader.dart';

class Comments {
  final String username;
  final String imageUrl;
  final String description;
  final String id;
  final int likes;

  Comments(
      {this.username, this.imageUrl, this.description, this.id, this.likes});
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'imageUrl': imageUrl,
      'description': description,
      'id': id,
      'likes': likes
    };
  }
}

class Likes {
  final String usersUsernamesLiked;
  final String usersProfilesLiked;

  final String id;

  Likes({this.usersUsernamesLiked, this.usersProfilesLiked, this.id});

  Map<String, dynamic> toJson() {
    return {
      'usernames': usersUsernamesLiked,
      'images': usersProfilesLiked,
      'userId': id,
    };
  }
}

class StoryModel {
  final String description;
  final String fullName;
  final String username;

  final Timestamp createdAt;
  final String imageUrl;
  final List<dynamic> postPics;
  final String userId;
  final String postId;

  StoryModel(
      {this.description,
      this.fullName,
      this.createdAt,
      this.username,
      this.imageUrl,
      this.postPics,
      this.userId,
      this.postId});
}

Widget cachedImage({String url, BoxFit fit, double width}) {
  return CachedNetworkImage(
    imageUrl: url,
    width: width,
    fit: fit == null ? BoxFit.cover : fit,
    progressIndicatorBuilder: (context, url, downloadProgress) =>
        Center(child: MyLoader()),
    errorWidget: (context, url, error) => Icon(Icons.error),
  );
}
