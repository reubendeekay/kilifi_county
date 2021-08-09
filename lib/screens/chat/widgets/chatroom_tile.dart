import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kilifi_county/constants.dart';
import 'package:kilifi_county/providers/user_provider.dart';
import 'package:kilifi_county/screens/chat/chatscreen.dart';

class ChatroomTile extends StatelessWidget {
  final String fullName;
  final String username;
  final String imageUrl;
  final String email;
  final String userId;
  final String subCounty;
  final String phoneNumber;
  final String nationalId;
  final bool isVerified;
  final String latestMessage;

  final Timestamp date;

  const ChatroomTile(
      {this.fullName,
      this.username,
      this.imageUrl,
      this.email,
      this.subCounty,
      this.userId,
      this.phoneNumber,
      this.nationalId,
      this.isVerified,
      this.latestMessage,
      this.date});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(ChatScreen.routeName,
            arguments: UserModel(
                email: email,
                fullName: fullName,
                imageUrl: imageUrl,
                isVerified: isVerified,
                nationalId: nationalId,
                phoneNumber: phoneNumber,
                subCounty: subCounty,
                userId: userId,
                username: username));
      },
      child: Container(
        margin: EdgeInsets.only(top: 10),
        height: 50,
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(imageUrl),
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
                                    fullName,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Container(
                                    height: 20,
                                    child: Text(
                                      latestMessage != null
                                          ? latestMessage
                                          : '',
                                      overflow: TextOverflow.ellipsis,
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
                                height: 2,
                              ),
                              Text(
                                date != null
                                    ? DateFormat.jm().format(date.toDate())
                                    : '',
                                style: TextStyle(fontSize: 12),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              CircleAvatar(
                                radius: 3.5,
                                backgroundColor: kPrimary,
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
