import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kilifi_county/constants.dart';
import 'package:kilifi_county/models/appointment_model.dart';
import 'package:kilifi_county/screens/services/appointments_screen.dart';
import 'package:kilifi_county/widgets/netwok_items.dart';

class UserAppointments extends StatelessWidget {
  static const routeName = '/user-appointment';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Appointments'),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          children: [
            AppointmentItems(),
            SizedBox(
              width: size.width * 0.8,
              height: 40,
              child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: kPrimary,
                  onPressed: () => Navigator.of(context)
                      .pushNamed(AppointmentsScreen.routeName),
                  child: Text(
                    'Make Appointment',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class UserAppointmentsFirst extends StatelessWidget {
  final String date;
  final String department;
  final String imageUrl;
  final String fullName;
  final String phoneNumber;
  final String idNo;
  final bool status;
  final String appointmentId;
  final String purpose;
  final String time;

  const UserAppointmentsFirst(
      {Key key,
      this.date,
      this.department,
      this.imageUrl,
      this.fullName,
      this.phoneNumber,
      this.idNo,
      this.status,
      this.appointmentId,
      this.purpose,
      this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              decoration: BoxDecoration(
                  color: kPrimary,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      'Appointment Request',
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                      child: Row(
                    children: [
                      Icon(Icons.watch_later),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '$date , $time',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      )
                    ],
                  ))
                ],
              )),
          Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: CachedNetworkImageProvider(imageUrl),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          department,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(phoneNumber)
                      ],
                    ),
                    Spacer(),
                    CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Icon(
                        Icons.info,
                        color: kPrimary,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Card(
                      color: kPrimary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: Container(
                        width: 150,
                        height: 35,
                        child: Center(
                          child: Text(
                            status ? 'APPROVED' : 'PENDING',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      color: kPrimary.withOpacity(0.3),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: Container(
                        width: 100,
                        height: 30,
                        child: Center(
                          child: Text(
                            'CANCEL',
                            style: TextStyle(color: kPrimary),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}

class UserAppointmentTile extends StatelessWidget {
  final String date;
  final String department;
  final String imageUrl;
  final String fullName;
  final String phoneNumber;
  final String idNo;
  final bool status;
  final String appointmentId;
  final String purpose;
  final String time;

  const UserAppointmentTile(
      {this.date,
      this.purpose,
      this.idNo,
      this.department,
      this.appointmentId,
      this.imageUrl,
      this.fullName,
      this.phoneNumber,
      this.status,
      this.time});
  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        margin: EdgeInsets.symmetric(vertical: 5),
        child: ListTile(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          leading: CircleAvatar(
            radius: 25,
            backgroundImage: CachedNetworkImageProvider(imageUrl),
          ),
          title: Row(
            children: [
              Text(department),
              Spacer(),
              Icon(
                status ? Icons.task_alt : Icons.task_alt,
                size: 16,
                color: status ? Colors.green : Colors.red,
              )
            ],
          ),
          subtitle: Text('$date at $time'),
          trailing: PopupMenuButton(
            itemBuilder: (ctx) => [
              PopupMenuItem(
                child: Text('Cancel Appointment'),
                value: 0,
              )
            ],
            onSelected: (i) {
              if (i == 0) {
                FirebaseFirestore.instance
                    .collection('admin')
                    .doc('appointments')
                    .collection('requests')
                    .doc(appointmentId)
                    .delete();
              }
            },
          ),
        ));
  }
}
