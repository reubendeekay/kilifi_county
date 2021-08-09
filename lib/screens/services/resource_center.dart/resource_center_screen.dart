import 'package:flutter/material.dart';
import 'package:kilifi_county/constants.dart';
import 'package:kilifi_county/screens/services/e_citizen_screen.dart';
import 'package:kilifi_county/screens/services/resource_center.dart/downloads_screen.dart';

class ResourceCenterScreen extends StatefulWidget {
  static const routeName = '/resource-center';

  @override
  _ResourceCenterScreenState createState() => _ResourceCenterScreenState();
}

class _ResourceCenterScreenState extends State<ResourceCenterScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 1,
        length: 4,
        child: Scaffold(
          appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text('Resource Center'),
              elevation: 0,
              bottom: TabBar(
                unselectedLabelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                    color: Colors.grey.shade100),
                labelStyle:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                isScrollable: true,
                indicatorColor: kPrimary,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(
                    child: Text('Departments'),
                  ),
                  Tab(
                    child: Text('Downloads'),
                  ),
                  Tab(
                    child: Text('Budget&Finances'),
                  ),
                  Tab(
                    child: Text('Perfomance Contract Docs'),
                  ),
                ],
              )),
          body: TabBarView(children: [
            DownloadsScreen('Departments'),
            DownloadsScreen('Downloads'),
            DownloadsScreen('Budget&Finances'),
            DownloadsScreen('Perfomance Contract Docs'),
          ]),
        ));
  }
}
