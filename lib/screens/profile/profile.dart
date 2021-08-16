import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kilifi_county/constants.dart';
import 'package:kilifi_county/providers/user_provider.dart';
import 'package:kilifi_county/screens/profile/connect_with_screen.dart';
import 'package:kilifi_county/screens/profile/saved_post_screen.dart';

import 'package:kilifi_county/screens/profile/user_appointments.dart';
import 'package:kilifi_county/screens/profile/verification_screen.dart';
import 'package:kilifi_county/screens/profile/widgets/account_details_screen.dart';
import 'package:kilifi_county/screens/profile/widgets/profile_tile.dart';
import 'package:kilifi_county/screens/services/consultation_screen.dart';
import 'package:provider/provider.dart';

class UserProfileScreen extends StatelessWidget {
  static const routeName = '/user-profile';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UsersProvider>(context).user;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            TopBar(user),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Account ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Divider(
                    thickness: 2,
                  )
                ],
              ),
            ),
            ProfileTile(
              function: () => Navigator.of(context)
                  .pushNamed(AccountDetailsScreen.routeName, arguments: user),
            ),
            ProfileTile(
              title: 'Request Verification',
              description: 'Get verified ',
              function: () =>
                  Navigator.of(context).pushNamed(VerificationScreen.routeName),
            ),
            ProfileTile(
              title: 'Appointments',
              description: 'View requested appointments',
              function: () =>
                  Navigator.of(context).pushNamed(UserAppointments.routeName),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Preferences',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Divider(
                    thickness: 2,
                  )
                ],
              ),
            ),
            ProfileSwitchTile(),
            ProfileTile(
              title: 'Saved Posts',
              description: 'View all your saved posts',
              function: () =>
                  Navigator.of(context).pushNamed(SavedPostScreen.routeName),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Support',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Divider(
                    thickness: 2,
                  )
                ],
              ),
            ),
            ProfileTile(
              title: 'Connect with us',
              description: 'Interact on social media',
              function: () =>
                  Navigator.of(context).pushNamed(ConnectScreen.routeName),
            ),
            ProfileTile(
              title: 'Need Help? Contact us',
              description: 'Get in touch with customer care',
              function: () async {
                await FirebaseFirestore.instance
                    .collection('interactions')
                    .doc('consultation')
                    .collection(user.userId)
                    .doc()
                    .set({'sessionAt': Timestamp.now()});
                Navigator.of(context)
                    .pushNamed(ConsultationScreen.routeName, arguments: {
                  'user': user,
                  'isChat': true,
                });
              },
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: ListTile(
                  title: Center(
                    child: Text(
                      'Log out',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                  ),
                  onTap: () => FirebaseAuth.instance.signOut(),
                  dense: true,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

//Top Bar
class TopBar extends StatefulWidget {
  final UserModel user;
  TopBar(this.user);

  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  File _image;

  @override
  Widget build(BuildContext context) {
    void _getImage() async {
      final pickedFile = await ImagePicker().getImage(
          source: ImageSource.gallery,
          imageQuality: 40,
          maxHeight: 400,
          maxWidth: 400);

      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('No image selected')));
        }
      });

      if (_image != null) {
        var file;
        file = await FirebaseStorage.instance
            .ref('users_profile_images/${widget.user.userId}')
            .putFile(_image)
            .whenComplete(() async {
          final url = await file.ref.getDownloadURL();
          await FirebaseFirestore.instance
              .collection('users')
              .doc(widget.user.userId)
              .update({'imageUrl': url});

          await FirebaseStorage.instance
              .ref('users_profile_images/${widget.user.userId}')
              .delete();
        });
      }
    }

    return Container(
      height: 200,
      child: ShaderMask(
        shaderCallback: (rect) {
          return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black,
              Colors.black,
              Colors.black,
              Colors.black,
              Colors.transparent
            ],
          ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
        },
        blendMode: BlendMode.dstIn,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [kPrimary, kPrimary, Colors.orange],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      CircleAvatar(
                        radius: 43,
                        backgroundImage: CachedNetworkImageProvider(
                          widget.user.imageUrl,
                        ),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 2,
                          child: GestureDetector(
                            onTap: _getImage,
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.red,
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 13,
                              ),
                            ),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Text(
                    widget.user.fullName,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    '@ ${widget.user.username}',
                    style: TextStyle(
                        fontWeight: FontWeight.w500, color: Colors.white),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
