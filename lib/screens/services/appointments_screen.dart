import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kilifi_county/constants.dart';
import 'package:kilifi_county/models/appointment_model.dart';
import 'package:kilifi_county/providers/user_provider.dart';
import 'package:kilifi_county/screens/services/appointment_status_screen.dart';

class AppointmentsScreen extends StatefulWidget {
  static const routeName = '/appoitments-screen';

  @override
  _AppointmentsScreenState createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  final _formKey = GlobalKey<FormState>();

  String fullName = '';

  String idNo = '';

  String phoneNumber = '';

  String purpose = '';

  DateTime date;
  TimeOfDay time;

  String defaultValue;

  List<String> items = [
    'Governor',
    'Deputy Governor',
    'County Secretary',
    'Chief Executive Council',
    'Speaker of County Assembly'
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final user = ModalRoute.of(context).settings.arguments as UserModel;

    void _trySubmit() async {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        showConfirmDialog(user);
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                Center(
                  child: Container(
                    child: Text(
                      'Complete your appointment details',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 40, 0, 8),
                  child: Text(
                    'PERSONAL DETAILS',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  child: Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: TextFormField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Legal name *',
                          hintStyle: TextStyle(fontSize: 14)),
                      onChanged: (value) {
                        fullName = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please include your official name';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  child: Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: TextFormField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'National ID No.',
                          hintStyle: TextStyle(fontSize: 14)),
                      onChanged: (value) {
                        idNo = value;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  child: Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: TextFormField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Active Phone number *',
                          hintStyle: TextStyle(fontSize: 14)),
                      onChanged: (value) {
                        phoneNumber = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please include your phone number for communication';
                        }
                        if (value.length < 8) {
                          return 'Please enter a valid number';
                        }

                        return null;
                      },
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 30, 0, 8),
                  child: Text(
                    'APPOINTMENT DETAILS',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    child: Padding(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                            onChanged: (value) {
                              setState(() {
                                defaultValue = value;
                              });
                            },
                            hint: Text('Office of appointment'),
                            isExpanded: true,
                            value: defaultValue,
                            icon: Icon(Icons.keyboard_arrow_down),
                            items: items
                                .map((e) => DropdownMenuItem(
                                      child: Text(e),
                                      value: e,
                                    ))
                                .toList()),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                  height: 45,
                                  child: Center(
                                      child: Text(date == null
                                          ? ''
                                          : DateFormat('dd/MM/yyyy')
                                              .format(date)
                                              .toString()))),
                            ),
                            IconButton(
                                onPressed: openCalendar,
                                icon: Icon(Icons.calendar_today_outlined)),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 130,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 45,
                                child: Center(
                                    child: Text(time == null
                                        ? ''
                                        : time.format(context))),
                              ),
                            ),
                            IconButton(
                                onPressed: openTime,
                                icon: Icon(Icons.watch_later_outlined)),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      maxLines: null,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Purpose for the appointment *',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please include the purpose of your appointment';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        purpose = value;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.1,
                ),
                Center(
                  child: SizedBox(
                    width: size.width - 100,
                    child: ElevatedButton(
                        onPressed: _trySubmit,
                        child: Text(
                          'Send proposal',
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void openCalendar() async {
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));
    setState(() {
      date = pickedDate;
    });
  }

  void openTime() async {
    final pickedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    setState(() {
      time = pickedTime;
    });
  }

  void showConfirmDialog(UserModel user) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              content: Text(
                  'Department : $defaultValue \nDate : ${DateFormat('dd/MM/yyyy').format(date)} \nTime : ${time.format(context)}'),
              title: Text('Confirm Details'),
              actions: [
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: Text(
                        'CANCEL',
                        style: TextStyle(color: Colors.grey),
                      ),
                    )),
                GestureDetector(
                    onTap: () async {
                      Navigator.of(context).pop();
                      final appointment = AppointmentModel(
                          date:
                              DateFormat('dd/MM/yyyy').format(date).toString(),
                          time: time.format(context).toString(),
                          department: defaultValue,
                          fullName: fullName,
                          idNo: idNo,
                          imageUrl: user.imageUrl,
                          phoneNumber: phoneNumber,
                          purpose: purpose,
                          userId: user.userId);
                      await FirebaseFirestore.instance
                          .collection('admin')
                          .doc('appointments')
                          .collection(defaultValue)
                          .doc()
                          .set({
                        'imageUrl': user.imageUrl,
                        'name': fullName,
                        'idNo': idNo,
                        'userId': user.userId,
                        'office': defaultValue,
                        'phoneNumber': phoneNumber,
                        'purpose': purpose,
                        'isApproved': false,
                        'date':
                            DateFormat('dd/MM/yyyy').format(date).toString(),
                        'time': time.format(context).toString()
                      }, SetOptions(merge: true));
                      Navigator.of(context).pushReplacementNamed(
                          AppointmentStatusScreen.routeName,
                          arguments: appointment);
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: Text(
                        'CONFIRM',
                        style: TextStyle(color: kPrimary),
                      ),
                    ))
              ],
            ));
  }
}
