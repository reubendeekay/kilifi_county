import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kilifi_county/constants.dart';
import 'package:kilifi_county/providers/user_provider.dart';
import 'package:kilifi_county/screens/profile/profile_tile.dart';
import 'package:provider/provider.dart';

class UserProfileScreen extends StatelessWidget {
  static const routeName = '/user-profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            TopBar(),
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
            ProfileTile(),
            ProfileTile(),
            ProfileTile(),
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
            ProfileTile(),
            ProfileTile(),
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
            ProfileTile(),
            ProfileTile(),
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
class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UsersProvider>(context).user;
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
                        backgroundImage: NetworkImage(
                          user.imageUrl,
                        ),
                      ),
                      Positioned(
                          bottom: 2,
                          right: 4,
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.red,
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 13,
                            ),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Text(
                    user.fullName,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    '@ ${user.username}',
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
