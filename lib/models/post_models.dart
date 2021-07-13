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
