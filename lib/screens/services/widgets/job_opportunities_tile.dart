import 'package:flutter/material.dart';
import 'package:kilifi_county/models/job_model.dart';
import 'package:kilifi_county/screens/services/job_details_screen.dart';

class JobOpportunitiesTile extends StatelessWidget {
  final String userId;
  final String fullName;
  final String username;
  final String jobId;
  final String link;
  final String description;
  final List<dynamic> postPics;
  final String imageUrl;

  const JobOpportunitiesTile(
      {this.userId,
      this.fullName,
      this.username,
      this.description,
      this.jobId,
      this.link,
      this.postPics,
      this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(JobDetailsScreen.routeName,
          arguments: JobModel(
            description: description,
            fullName: fullName,
            imageUrl: imageUrl,
            jobId: jobId,
            link: link,
            postPics: postPics,
            userId: userId,
            username: username,
          )),
      child: Container(
        height: 275,
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                width: double.infinity,
                child: Image.network(
                  postPics.first,
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                height: 50,
                margin: EdgeInsets.symmetric(vertical: 7.5, horizontal: 5),
                child: Text(
                  description,
                  softWrap: true,
                  overflow: TextOverflow.fade,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
