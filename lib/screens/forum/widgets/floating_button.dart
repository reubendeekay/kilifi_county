import 'dart:typed_data';

import 'package:drishya_picker/drishya_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:kilifi_county/constants.dart';
import 'package:kilifi_county/screens/forum/add_post_screen.dart';
import 'package:kilifi_county/screens/home/forum_screen.dart';
import 'package:kilifi_county/screens/custom%20gallery/custom_gallery.dart';

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
    notifier = ValueNotifier(<DrishyaEntity>[]);

    scrollController = ScrollController()
      ..addListener(() {
        setDialVisible(scrollController.position.userScrollDirection ==
            ScrollDirection.forward);
      });
  }

  @override
  void dispose() {
    notifier.dispose();
    super.dispose();
  }

  void setDialVisible(bool value) {
    setState(() {
      dialVisible = value;
    });
  }

  ValueNotifier<List<DrishyaEntity>> notifier;

  SpeedDial buildSpeedDial() {
    return SpeedDial(
      /// both default to 16

      childMargin: EdgeInsets.only(left: 18, bottom: 20),

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

      gradientBoxShape: BoxShape.circle,

      gradient: LinearGradient(
        colors: [kPrimary, kPrimary],
      ),
      children: [
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
        ),
        SpeedDialChild(
          child: ValueListenableBuilder<List<DrishyaEntity>>(
            valueListenable: notifier,
            builder: (context, list, child) {
              return GalleryViewField(
                selectedEntities: list,
                onChanged: (entity, isRemoved) {
                  final value = notifier.value.toList();
                  if (isRemoved) {
                    value.remove(entity);
                  } else {
                    value.add(entity);
                  }
                  notifier.value = value;
                },
                onSubmitted: (list) async {
                  notifier.value = list;
                  List files;
                  list.forEach((element) async {
                    final file =
                        element.entity.file.then((value) => value.path);
                    await ImageCropper.cropImage(
                        sourcePath: await file,
                        aspectRatioPresets: [
                          CropAspectRatioPreset.square,
                          CropAspectRatioPreset.ratio3x2,
                          // CropAspectRatioPreset.original,
                          CropAspectRatioPreset.ratio4x3,
                          CropAspectRatioPreset.ratio16x9
                        ],
                        androidUiSettings: AndroidUiSettings(
                            toolbarTitle: 'Crop',
                            toolbarColor: Theme.of(context).primaryColor,
                            toolbarWidgetColor: Colors.white,
                            initAspectRatio: CropAspectRatioPreset.original,
                            lockAspectRatio: false),
                        iosUiSettings: IOSUiSettings(
                          minimumAspectRatio: 1.0,
                        ));
                  });

                  if (list != null)
                    Navigator.of(context)
                        .pushNamed(AddPostScreen.routeName, arguments: list);
                },
                child: child,
              );
            },
            child: Icon(
              Icons.photo_camera_back_outlined,
              color: kPrimary,
            ),
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
          onTap: () {},
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
