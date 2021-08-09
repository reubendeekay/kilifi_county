class NewsModel {
  final String index;
  final String fullName;
  final List<dynamic> images;
  final String profilePic;
  final String title;
  final String article;
  final int views;
  final String username;
  final String postId;
  final String date;

  NewsModel(
      {this.index,
      this.fullName,
      this.images,
      this.profilePic,
      this.title,
      this.article,
      this.views,
      this.username,
      this.postId,
      this.date});
}
