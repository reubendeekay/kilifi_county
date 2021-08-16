import 'package:cloud_firestore/cloud_firestore.dart';

class JobModel {
  final String userId;
  final String fullName;
  final String username;
  final String jobId;
  final String link;
  final Timestamp createdAt;
  final String description;
  final String jobPoster;
  final String imageUrl;

  JobModel({
    this.userId,
    this.fullName,
    this.username,
    this.jobId,
    this.createdAt,
    this.link,
    this.description,
    this.jobPoster,
    this.imageUrl,
  });
}
