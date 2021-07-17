import 'package:flutter/material.dart';

import 'package:kilifi_county/screens/chat/widgets/chat_network.dart';

class ConsultationScreen extends StatelessWidget {
  static const routeName = '/consultation';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consultation'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(),
          ),
          AddMessage()
        ],
      ),
    );
  }
}
