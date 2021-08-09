import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kilifi_county/screens/services/widgets/job_opportunities_tile.dart';

class JobOpportunitiesScreen extends StatelessWidget {
  static const routeName = '/job-opportunities';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Employment Opportunities'),
          automaticallyImplyLeading: false,
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('admin')
                .doc('admin_data')
                .collection('jobs')
                .snapshots(),
            builder: (ctx, snapshots) {
              if (snapshots.hasData && !snapshots.hasError) {
                List<DocumentSnapshot> documents = snapshots.data.docs;
                return ListView(
                  children: documents
                      .map((e) => JobOpportunitiesTile(
                            description: e['description'],
                            fullName: e['fullName'],
                            imageUrl: e['imageUrl'],
                            jobId: e['jobId'],
                            link: e['link'],
                            postPics: e['postPics'],
                            userId: e['userId'],
                            username: e['username'],
                          ))
                      .toList(),
                );
              } else {
                return Container();
              }
            }));
  }
}
