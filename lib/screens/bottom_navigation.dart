import 'package:flutter/material.dart';
import 'package:kilifi_county/constants.dart';
import 'package:kilifi_county/screens/home.dart';
import 'package:kilifi_county/screens/profile/profile.dart';
import 'package:kilifi_county/screens/services/services_screen.dart';
import 'package:kilifi_county/screens/forum/widgets/floating_button.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class MyNav extends StatefulWidget {
  @override
  _MyNavState createState() => _MyNavState();
}

class _MyNavState extends State<MyNav> {
  int _currentIndex = 0;

  List _pages = [
    Homepage(),
    ServicesScreen(),
    FloatingButton(),
    UserProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          SalomonBottomBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
            selectedColor: kPrimary,
          ),

          /// Services
          SalomonBottomBarItem(
            icon: Icon(Icons.eco_outlined),
            title: Text("Services"),
            selectedColor: kSecondary,
          ),

          /// Search
          SalomonBottomBarItem(
            icon: Icon(Icons.forum_outlined),
            title: Text("Forum"),
            selectedColor: Colors.blueAccent,
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: Icon(Icons.person),
            title: Text("Profile"),
            selectedColor: kPrimary,
          ),
        ],
      ),
    );
  }
}
