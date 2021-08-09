import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kilifi_county/screens/services/widgets/gallery_item.dart';

class GalleryScreen extends StatelessWidget {
  static const routeName = '/gallery-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('County Gallery'),
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('admin')
              .doc('admin_data')
              .collection('gallery')
              .snapshots(),
          builder: (ctx, snapshots) {
            if (snapshots.hasData && !snapshots.hasError) {
              List<DocumentSnapshot> documents = snapshots.data.docs;
              return ListView(
                  children: documents
                      .map((e) => GalleryItem(
                            caption: e['caption'],
                            images: e['galleryPics'],
                            postId: e['postId'],
                          ))
                      .toList());
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}
