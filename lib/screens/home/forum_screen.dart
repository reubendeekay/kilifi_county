import 'package:flutter/material.dart';
import 'package:kilifi_county/screens/forum/forum_search_screen.dart';

import 'package:kilifi_county/widgets/netwok_items.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

class Forum extends StatelessWidget {
  final _appBarController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScrollAppBar(
        controller: _appBarController,
        title: Text(
          'Kilifi County Forum',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(ForumSearchScreen.routeName),
              icon: Icon(Icons.search)),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: Snap(
        controller: _appBarController.appBar,
        child: SafeArea(
          child: Container(
              child: ListView(
                  controller: _appBarController, children: [ForumPosts()])),
        ),
      ),
    );
  }
}
