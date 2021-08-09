import 'package:flutter/material.dart';
import 'package:kilifi_county/providers/user_provider.dart';

import 'package:kilifi_county/screens/chat/widgets/chat_network.dart';

class ConsultationScreen extends StatelessWidget {
  static const routeName = '/consultation';
  @override
  Widget build(BuildContext context) {
    final data =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    UserModel user;

    if (data['user'] != null) {
      user = data['user'];
    }
    ;
    final isChat = data['isChat'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Consultation'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: Chats(isConsultation: isChat),
          ),
          AddMessage(isConsultation: isChat)
        ],
      ),
    );
  }
}
