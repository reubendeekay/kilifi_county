import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:kilifi_county/models/post_models.dart';
import 'package:kilifi_county/screens/services/gallery_fullscree.dart';

class GalleryItem extends StatefulWidget {
  final String caption;
  final String postId;
  final List<dynamic> images;

  const GalleryItem({this.caption, this.postId, this.images});
  @override
  State<StatefulWidget> createState() {
    return _GalleryItemState();
  }
}

class _GalleryItemState extends State<GalleryItem> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = widget.images
        .map((item) => Container(
              child: GestureDetector(
                onTap: () => Navigator.of(context)
                    .pushNamed(GalleryFullscreen.routeName, arguments: {
                  'postId': widget.postId,
                  'caption': widget.caption,
                  'images': widget.images
                }),
                child: Container(
                  margin: EdgeInsets.all(5.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      child: Stack(
                        children: <Widget>[
                          cachedImage(
                            url: item,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          )
                        ],
                      )),
                ),
              ),
            ))
        .toList();
    return Container(
      child: Column(
        children: [
          Container(
            height: 200,
            child: Stack(children: [
              CarouselSlider(
                items: imageSliders,
                carouselController: _controller,
                options: CarouselOptions(
                    autoPlay: false,
                    enlargeCenterPage: true,
                    height: 200.0,
                    disableCenter: true,
                    viewportFraction: 1,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }),
              ),
              Align(
                // bottom: 5,
                alignment: Alignment(1, 1),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.images.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => _controller.animateToPage(entry.key),
                      child: Container(
                        width: 6.0,
                        height: 6.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 4.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                (Theme.of(context).brightness == Brightness.dark
                                        ? Colors.white
                                        : Colors.black)
                                    .withOpacity(
                                        _current == entry.key ? 0.9 : 0.4)),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ]),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.fromLTRB(12, 1, 10, 5),
            child: Text(
              widget.caption,
              style: TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w300),
            ),
          )
        ],
      ),
    );
  }
}
