import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:intl/intl.dart';
import 'chat.dart';
import 'util.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key key}) : super(key: key);

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  void _handlePressed(types.User otherUser, BuildContext context) async {
    final room = await FirebaseChatCore.instance.createRoom(otherUser);

    Navigator.of(context).pop();
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChatPage(
          room: room,
        ),
      ),
    );
  }

  final searchController = TextEditingController();

  Widget _buildAvatar(types.User user) {
    final color = getUserAvatarNameColor(user);
    final hasImage = user.imageUrl != null;
    final name = getUserName(user);

    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: CircleAvatar(
        backgroundColor: color,
        backgroundImage:
            hasImage ? CachedNetworkImageProvider(user.imageUrl) : null,
        radius: 25,
        child: !hasImage
            ? Text(
                name.isEmpty ? '' : name[0].toUpperCase(),
                style: const TextStyle(color: Colors.white),
              )
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: searchController,
                  maxLines: null,
                  decoration: InputDecoration(
                      hintText: 'Search for a user',
                      hintStyle: TextStyle(fontSize: 14),
                      border: InputBorder.none,
                      suffixIcon: Hero(
                          tag: 'icon',
                          transitionOnUserGestures: true,
                          child: Icon(Icons.search))),
                  onChanged: (_) {
                    setState(() {});
                  },
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<List<types.User>>(
                stream: searchController.text.isEmpty
                    ? FirebaseChatCore.instance.users()
                    : FirebaseChatCore.instance.searchUsers(
                        toBeginningOfSentenceCase(searchController.text)),
                initialData: const [],
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.data.isEmpty) {
                    return Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(
                        bottom: 200,
                      ),
                      child: const Text('No users'),
                    );
                  }

                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      final user = snapshot.data[index];

                      return GestureDetector(
                        onTap: () {
                          _handlePressed(user, context);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  _buildAvatar(user),
                                  Column(
                                    children: [
                                      Text(
                                        getUserName(user),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      // Text(
                                      //   getuserName(user),
                                      //   style: TextStyle(
                                      //       fontWeight: FontWeight.w500),
                                      // ),
                                    ],
                                  ),
                                ],
                              ),
                              Divider()
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
