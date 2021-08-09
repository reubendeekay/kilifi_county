class JobModel {
  final String userId;
  final String fullName;
  final String username;
  final String jobId;
  final String link;
  final String description;
  final List<dynamic> postPics;
  final String imageUrl;

  JobModel(
      {this.userId,
      this.fullName,
      this.username,
      this.jobId,
      this.link,
      this.description,
      this.postPics,
      this.imageUrl});
}
