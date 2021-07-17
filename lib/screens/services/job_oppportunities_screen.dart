import 'package:flutter/material.dart';
import 'package:kilifi_county/screens/services/widgets/job_opportunities_tile.dart';

class JobOpportunitiesScreen extends StatelessWidget {
  static const routeName = '/job-opportunities';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employment Opportunities'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            JobOpportunitiesTile(),
            JobOpportunitiesTile(),
            JobOpportunitiesTile(),
          ],
        ),
      ),
    );
  }
}
