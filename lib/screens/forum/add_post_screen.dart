import 'dart:io';
import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:drishya_picker/drishya_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kilifi_county/constants.dart';
import 'package:kilifi_county/providers/dark_mode_provider.dart';
import 'package:kilifi_county/providers/post_provider.dart';
import 'package:kilifi_county/providers/user_provider.dart';
import 'package:kilifi_county/screens/custom%20gallery/custom_gallery.dart';

import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  static const routeName = '/add-post';
  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final _formKey = GlobalKey<FormState>();
  String message = '';
  List<Uint8List> _image = [];
  final CarouselController _controller = CarouselController();
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    List<DrishyaEntity> _obtainedFile =
        ModalRoute.of(context).settings.arguments;
    final dark = Provider.of<DarkThemeProvider>(context);
    final user = Provider.of<UsersProvider>(context).user;

    _obtainedFile != null
        ? _obtainedFile.forEach((element) {
            _image.add(element.bytes);
          })
        : null;
    _obtainedFile = null;

    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                              content: Text('Delete this draft?'),
                              actions: [
                                TextButton(
                                  child: Text('DELETE'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                    child: Text('CANCEL'),
                                    onPressed: () =>
                                        Navigator.of(context).pop()),
                              ],
                            ));
                  },
                  icon: FaIcon(FontAwesomeIcons.times)),
              Spacer(),
              SizedBox(
                height: 35,
                width: 80,
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: kPrimary,
                    onPressed: () async {
                      _formKey.currentState.save();
                      Provider.of<PostProvider>(context, listen: false).addPost(
                          Post(
                            comments: null,
                            description: message,
                            imageFile: _image,
                            likes: null,
                            user: user,
                          ),
                          context);

                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Post',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    )),
              )
            ],
          )),
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            // physics: NeverScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: size.height - 145,
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  // color: kSecondary,
                  child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 15,
                                backgroundImage: NetworkImage(user.imageUrl),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      user.fullName,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13),
                                    ),
                                    Text(
                                      '@ ${user.username}',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: Colors.grey,
                                          fontSize: 13),
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              SizedBox(
                                  height: 30,
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.more_vert))),
                            ],
                          ),
                          //If the User had selected the photos Option//........................................
                          if (_image.isNotEmpty)
                            Container(
                              constraints:
                                  BoxConstraints(maxHeight: size.height * 0.68),
                              margin: EdgeInsets.only(top: 5, left: 2),
                              width: double.infinity,
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    height: size.width,
                                    child: Stack(children: [
                                      CarouselSlider(
                                        items: _image
                                            .map((e) => Container(
                                                  width: size.width,
                                                  height: size.width,
                                                  child: Image.memory(
                                                    e,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ))
                                            .toList(),
                                        carouselController: _controller,
                                        options: CarouselOptions(
                                            autoPlay: false,
                                            enlargeCenterPage: true,
                                            height: size.width,
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: _image
                                              .asMap()
                                              .entries
                                              .map((entry) {
                                            return GestureDetector(
                                              onTap: () => _controller
                                                  .animateToPage(entry.key),
                                              child: Container(
                                                width: 6.0,
                                                height: 6.0,
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 10.0,
                                                    horizontal: 4.0),
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: (Theme.of(context)
                                                                    .brightness ==
                                                                Brightness.dark
                                                            ? Colors.white
                                                            : Colors.black)
                                                        .withOpacity(_current ==
                                                                entry.key
                                                            ? 0.9
                                                            : 0.4)),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ]),
                                  ),
                                ),
                              ),
                            ),

                          //.....................................................

                          Form(
                            key: _formKey,
                            child: Container(
                                width: size.width,
                                child: Card(
                                  color: dark.darkTheme
                                      ? Colors.black
                                      : Colors.grey[50],
                                  elevation: 0.1,
                                  child: TextFormField(
                                    enableSuggestions: true,
                                    autocorrect: true,
                                    maxLines: null,
                                    decoration: InputDecoration(
                                        hintText: 'Whats happening?',
                                        border: InputBorder.none),
                                    onChanged: (value) {
                                      message = value;
                                    },
                                  ),
                                )),
                          )
                        ]),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    // border: BorderDirectional(
                    //     top: BorderSide(color: Colors.grey, width: 0.5)),
                    color: dark.darkTheme ? Colors.black : Colors.grey[100],
                  ),
                  height: 60,
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 60,
                            width: 50,
                            child: GestureDetector(
                              onTap: () => Navigator.of(context)
                                  .popAndPushNamed(Gallery.routeName),
                              child: Icon(
                                Icons.photo_camera_back_outlined,
                                color: kPrimary.shade200,
                                size: 35,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          // Expanded(child: Gallery())
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
