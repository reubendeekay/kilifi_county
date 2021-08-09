import 'package:flutter/material.dart';
import 'package:kilifi_county/widgets/netwok_items.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

class SavedPostScreen extends StatelessWidget {
  static const routeName = '/saved-post-screen';
  final _appBarController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScrollAppBar(
        controller: _appBarController,
        title: Text(
          'Saved Posts',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Snap(
        controller: _appBarController.appBar,
        child: SafeArea(
          child: Container(
              child: ListView(
                  controller: _appBarController, children: [SavedPost()])),
        ),
      ),
    );
  }
}
