import 'package:flutter/material.dart';
import 'package:kilifi_county/screens/chat/widgets/chatroom_tile.dart';

class ChatRooms extends StatelessWidget {
  static const routeName = '/chatrooms';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Connect'),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(
                height: 45,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: EdgeInsets.only(left: 1),
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search',
                          prefixIcon: Icon(
                            Icons.search,
                            size: 20,
                          )),
                    ),
                  ),
                ),
              ),
              ChatroomTile(),
              ChatroomTile(),
              ChatroomTile(),
            ],
          ),
        ),
      ),
    );
  }
}
