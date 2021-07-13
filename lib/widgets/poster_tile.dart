import 'dart:ui';

import 'package:dashed_circle/dashed_circle.dart';
import 'package:flutter/material.dart';

class PosterTile extends StatefulWidget {
  @override
  _PosterTileState createState() => _PosterTileState();
}

class _PosterTileState extends State<PosterTile>
    with SingleTickerProviderStateMixin {
  Animation gap;
  Animation<double> base;
  Animation<double> reverse;
  AnimationController controller;

  /// Init
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 4));
    base = CurvedAnimation(parent: controller, curve: Curves.easeOut);
    reverse = Tween<double>(begin: 0.0, end: -1.0).animate(base);
    gap = Tween<double>(begin: 3.0, end: 0.0).animate(base)
      ..addListener(() {
        setState(() {});
      });
    controller.forward();
  }

  /// Dispose
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          showDialog(context: context, builder: (_) => PosterFullScreen()),
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 8, bottom: 10, top: 2),
        child: RotationTransition(
          turns: base,
          child: DashedCircle(
            gapSize: gap.value,
            dashes: 30,
            color: Colors.deepOrange,
            child: RotationTransition(
              turns: reverse,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: CircleAvatar(
                  radius: 25.0,
                  backgroundImage: AssetImage('assets/images/poster.jpg'),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Stories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(children: [
          PosterTile(),
          PosterTile(),
          PosterTile(),
          PosterTile(),
          PosterTile(),
          PosterTile(),
          PosterTile(),
        ]),
      ),
    );
  }
}

class PosterFullScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Stack(
          children: [
            Container(
              width: size.width - 50,
              height: size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: ExactAssetImage('assets/images/poster.jpg'),
                      fit: BoxFit.fill)),
            ),
            Positioned(
                bottom: 0,
                child: Container(
                  width: size.width - 50,
                  color: Colors.black38,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                        'There are many opportunities for the citizens of Kilifi county'),
                  ),
                )),
            Positioned(
                left: 5,
                top: 5,
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/profile.jpg'),
                      radius: 15,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        'Reuben Jefwa',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            backgroundColor: Colors.black12),
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
