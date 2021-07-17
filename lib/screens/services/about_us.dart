import 'package:flutter/material.dart';
import 'package:kilifi_county/screens/services/widgets/gallery_item.dart';

class AboutUs extends StatelessWidget {
  static const routeName = '/about-us';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(slivers: <Widget>[
      SliverAppBar(
          elevation: 0,
          expandedHeight: 250,
          floating: false,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text("Welcome to Kilifi County",
                  style: TextStyle(
                    fontSize: 15.0,
                  )),
              background: GalleryItem())),
      SliverList(
          delegate: SliverChildBuilderDelegate(
        (context, i) => Column(
          children: [Container()],
        ),
      ))
    ]));
  }
}
