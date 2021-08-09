import 'package:flutter/material.dart';
import 'package:kilifi_county/models/appointment_model.dart';
import 'package:kilifi_county/widgets/netwok_items.dart';

class UserAppointments extends StatelessWidget {
  static const routeName = '/user-appointment';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Appointments'),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          children: [AppointmentItems()],
        ),
      ),
    );
  }
}

class UserAppointmentTile extends StatelessWidget {
  final String date;
  final String department;
  final bool status;
  final String time;

  const UserAppointmentTile(
      {this.date, this.department, this.status, this.time});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Row(children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Text(time,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              SizedBox(height: 10),
              Text(date,
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
            ],
          ),
        ),
        Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                Text(
                  'Office of the $department',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Text('Status: '),
                    Container(
                        width: 70,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(5)),
                        padding: EdgeInsets.all(2),
                        child: Text(status ? 'Approved' : 'Pending'))
                  ],
                )
              ],
            ))
      ]),
    );
  }
}
