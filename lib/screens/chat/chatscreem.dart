import 'package:flutter/material.dart';
import 'package:kilifi_county/screens/chat/widgets/chat_network.dart';

class ChatScreen extends StatelessWidget {
  static const routeName = '/chatscreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile.jpg'),
            ),
            SizedBox(
              width: 10,
            ),
            Text('Reuben Jefwa'),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            Expanded(
              child: Chats(),
            ),
            AddMessage(),
          ],
        ),
      ),
    );
  }
}
