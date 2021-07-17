import 'package:flutter/material.dart';
import 'package:kilifi_county/constants.dart';

class AppointmentStatusScreen extends StatelessWidget {
  static const routeName = '/appointment-status';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.05,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: size.height * 0.4,
            width: double.infinity,
            child: Image.asset(
              'assets/images/appointment.png',
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          Container(
              width: size.width - 70,
              margin: EdgeInsets.symmetric(vertical: 5),
              child: Center(
                child: Text(
                  'Hello Reuben,',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              )),
          Container(
              width: size.width - 70,
              margin: EdgeInsets.symmetric(vertical: 5),
              child: Center(
                child: Text(
                    'Your appointment proposal has\n been sent successfully',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
              )),
          SizedBox(
            height: size.height * 0.1,
          ),
          Center(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_active_rounded,
                    size: 32,
                    color: kPrimary,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'You will receive a notification \nonce it has been confirmed',
                    style: TextStyle(color: kPrimary, fontSize: 18),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.notifications_active_rounded,
                    size: 32,
                    color: kPrimary,
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
          SizedBox(
            width: size.width - 70,
            child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'Okay',
                  style: TextStyle(color: Colors.white),
                )),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
