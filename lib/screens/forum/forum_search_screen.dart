import 'package:flutter/material.dart';

class ForumSearchScreen extends StatefulWidget {
  static const routeName = '/forum-search-screen';

  @override
  _ForumSearchScreenState createState() => _ForumSearchScreenState();
}

class _ForumSearchScreenState extends State<ForumSearchScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 45,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search Kilifi County Forum',
                    suffixIcon: Icon(Icons.search)),
              ),
            ),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
    );
  }
}
