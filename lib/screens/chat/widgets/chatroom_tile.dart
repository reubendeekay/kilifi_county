import 'package:flutter/material.dart';
import 'package:kilifi_county/constants.dart';
import 'package:kilifi_county/screens/chat/chatscreem.dart';

class ChatroomTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(ChatScreen.routeName),
      child: Container(
        margin: EdgeInsets.only(top: 10),
        height: 50,
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile.jpg'),
              radius: 23,
            ),
            Expanded(
              child: Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Reuben Jefwa',
                                    overflow: TextOverflow.fade,
                                    softWrap: true,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Container(
                                    height: 20,
                                    child: Text(
                                      'This is a test message from Reuben Jefwa',
                                      overflow: TextOverflow.fade,
                                      softWrap: true,
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 5),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                '23:50',
                                style: TextStyle(fontSize: 12),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              CircleAvatar(
                                radius: 9,
                                backgroundColor: kPrimary,
                                child: FittedBox(
                                  child: Text(
                                    '2',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    Divider(
                      height: 4,
                      thickness: 0.5,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
