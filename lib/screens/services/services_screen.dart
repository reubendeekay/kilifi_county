import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kilifi_county/providers/user_provider.dart';

import 'package:kilifi_county/screens/services/appointments_screen.dart';
import 'package:kilifi_county/screens/services/consultation_screen.dart';
import 'package:kilifi_county/screens/services/e_citizen_screen.dart';
import 'package:kilifi_county/screens/services/gallery_screen.dart';
import 'package:kilifi_county/screens/services/job_oppportunities_screen.dart';
import 'package:kilifi_county/screens/services/resource_center.dart/resource_center_screen.dart';
import 'package:provider/provider.dart';

class ServicesScreen extends StatelessWidget {
  static const routeName = '/services';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UsersProvider>(context).user;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hi, ${user.username}.',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      width: 270,
                      child: Text(
                        'Welcome to Kilifi County\nServices',
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                )),
            Center(
              child: Container(
                margin: EdgeInsets.only(bottom: 20),
                height: 120,
                child: Image.asset(
                  'assets/images/service.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 3.5 / 2,
                children: [
                  ServiceTile(
                    color: Colors.amber[200],
                    title: 'Appointments',
                    function: () => Navigator.of(context).pushNamed(
                        AppointmentsScreen.routeName,
                        arguments: user),
                  ),
                  ServiceTile(
                    color: Colors.teal[200],
                    title: 'E-Citizen \nServices',
                    function: () => Navigator.of(context)
                        .pushNamed(ECitizenScreen.routeName),
                  ),
                  ServiceTile(
                    color: Colors.deepPurple[200],
                    title: 'Resource Center',
                    function: () => Navigator.of(context)
                        .pushNamed(ResourceCenterScreen.routeName),
                  ),
                  ServiceTile(
                    color: Colors.red[200],
                    title: 'Job/Intern Opportunities',
                    function: () => Navigator.of(context)
                        .pushNamed(JobOpportunitiesScreen.routeName),
                  ),
                  ServiceTile(
                      color: Colors.cyan[200],
                      function: () async {
                        Navigator.of(context).pushNamed(
                            ConsultationScreen.routeName,
                            arguments: {
                              'user': user,
                              'isChat': true,
                            });
                      }),
                  ServiceTile(
                    color: Colors.green[200],
                    title: 'Gallery',
                    function: () => Navigator.of(context)
                        .pushNamed(GalleryScreen.routeName),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ServiceTile extends StatelessWidget {
  final Color color;
  final String title;
  final Function function;

  ServiceTile({this.color, this.title, this.function});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          color: color,
          child: Center(
              child: Text(
            title != null ? title : 'Consultation',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          )),
        ),
      ),
    );
  }
}
