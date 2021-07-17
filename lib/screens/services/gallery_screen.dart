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
      body: Column(
        children: [GalleryItem(), GalleryItem()],
      ),
    );
  }
}
