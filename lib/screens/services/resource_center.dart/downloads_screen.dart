import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DownloadsScreen extends StatelessWidget {
  final String name;
  DownloadsScreen(this.name);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('admin')
          .doc('documents')
          .collection(name)
          .snapshots(),
      builder: (ctx, snapshot) {
        if (snapshot.hasData && !snapshot.hasError) {
          List<DocumentSnapshot> documents = snapshot.data.docs;

          return ListView(
              children: documents
                  .map((e) => DownloadTile(
                        fileName: e['docName'],
                        url: e['url'],
                      ))
                  .toList());
        } else {
          return Container();
        }
      },
    );
  }
}

class DownloadTile extends StatelessWidget {
  final String fileName;
  final String url;
  DownloadTile({this.fileName, this.url});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            Container(
                width: 50,
                child: FaIcon(
                  FontAwesomeIcons.filePdf,
                  color: Colors.red,
                  size: 50,
                )),
            Container(
              width: size.width - 90,
              margin: EdgeInsets.only(left: 10),
              child: Text(fileName.toUpperCase()),
            ),
          ],
        ));
  }
}
