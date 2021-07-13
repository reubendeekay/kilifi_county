import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kilifi_county/constants.dart';
import 'package:kilifi_county/screens/add_post_screen.dart';
import 'package:kilifi_county/screens/forum/forum_screen.dart';
import 'package:kilifi_county/widgets/media_grid.dart';

class FloatingButton extends StatefulWidget {
  static const routeName = '/forum';

  @override
  FloatingButtonState createState() => FloatingButtonState();
}

class FloatingButtonState extends State<FloatingButton>
    with TickerProviderStateMixin {
  ScrollController scrollController;
  bool dialVisible = true;

  @override
  void initState() {
    super.initState();

    scrollController = ScrollController()
      ..addListener(() {
        setDialVisible(scrollController.position.userScrollDirection ==
            ScrollDirection.forward);
      });
  }

  void setDialVisible(bool value) {
    setState(() {
      dialVisible = value;
    });
  }

  SpeedDial buildSpeedDial() {
    return SpeedDial(
      /// both default to 16
      marginEnd: 18,
      marginBottom: 20,

      icon: Icons.add,

      activeIcon: Icons.remove,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),

      buttonSize: 50.0,
      visible: true,

      /// If true user is forced to close dial manually
      /// by tapping main button and overlay is not rendered.
      closeManually: false,
      curve: Curves.bounceIn,
      overlayColor: Colors.black,
      overlayOpacity: 0.5,
      onOpen: () => print('OPENING DIAL'),
      onClose: () => print('DIAL CLOSED'),
      tooltip: 'Speed Dial',
      heroTag: 'speed-dial-hero-tag',
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 8.0,
      shape: CircleBorder(),

      orientation: SpeedDialOrientation.Up,
      childMarginBottom: 0,
      childMarginTop: 0,
      gradientBoxShape: BoxShape.circle,

      gradient: LinearGradient(
        colors: [kPrimary, kPrimary],
      ),
      children: [
        SpeedDialChild(
          labelWidget: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'First',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                    color: Colors.white),
              )),
          child: Icon(
            Icons.accessibility,
            color: kPrimary,
          ),
          backgroundColor: kPrimary.shade100.withOpacity(0.6),
          onTap: () => print('FIRST CHILD'),
          onLongPress: () => print('FIRST CHILD LONG PRESS'),
        ),
        SpeedDialChild(
          child: Center(
              child: FaIcon(
            FontAwesomeIcons.comment,
            size: 22,
            color: kPrimary,
          )),
          backgroundColor: kPrimary.shade100.withOpacity(0.6),
          labelWidget: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Tweet',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                    color: Colors.white),
              )),
          onTap: () => Navigator.of(context).pushNamed(AddPostScreen.routeName),
          onLongPress: () => print('SECOND CHILD LONG PRESS'),
        ),
        SpeedDialChild(
          child: Icon(
            Icons.photo_camera_back_outlined,
            color: kPrimary,
          ),
          backgroundColor: kPrimary.shade100.withOpacity(0.6),
          labelWidget: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Photos',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                    color: Colors.white),
              )),
          onTap: () {
            Navigator.of(context).pushNamed(Gallery.routeName);
            // Navigator.of(context)
            //     .pushNamed(AddPostScreen.routeName, arguments: _image);
          },
          onLongPress: () => print('THIRD CHILD LONG PRESS'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Forum(),
      floatingActionButton: buildSpeedDial(),
    );
  }
}
