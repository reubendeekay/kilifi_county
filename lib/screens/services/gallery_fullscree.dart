import 'package:flutter/material.dart';
import 'package:kilifi_county/models/post_models.dart';

class GalleryFullscreen extends StatelessWidget {
  static const routeName = '/gallery-full-screen';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final gallery =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              Container(
                height: size.height,
                width: size.width,
                color: Colors.grey.withOpacity(0.3),
              ),
              ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, i) => Hero(
                    tag: gallery['postId'],
                    transitionOnUserGestures: true,
                    child: Center(
                      child: cachedImage(
                        url: gallery['images'][i],
                      ),
                    )),
                itemCount: gallery['images'].length,
              )
            ],
          ),
        ),
      ),
    );
  }
}
