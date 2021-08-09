import 'package:flutter/material.dart';
import 'package:kilifi_county/providers/user_provider.dart';
import 'package:kilifi_county/screens/chat/widgets/chat_network.dart';

class ChatScreen extends StatelessWidget {
  static const routeName = '/chatscreen';
  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context).settings.arguments as UserModel;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(user.imageUrl),
              radius: 23,
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(user.fullName,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500)),
                    SizedBox(
                      width: 8,
                    ),
                    if (user.isVerified)
                      Icon(Icons.verified, color: Colors.blue, size: 18)
                  ],
                ),
                Text(
                  '@${user.username}',
                  style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            Expanded(
              child: Chats(userId: user.userId, isConsultation: false),
            ),
            AddMessage(
              isConsultation: false,
              toUser: user,
            ),
          ],
        ),
      ),
    );
  }
}
