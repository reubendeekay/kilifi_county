import 'package:flutter/material.dart';

class AccountDetailsScreen extends StatelessWidget {
  static const routeName = '/account-details';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Details'),
      ),
    );
  }
}
