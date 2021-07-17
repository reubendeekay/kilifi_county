import 'package:flutter/material.dart';
import 'package:kilifi_county/screens/services/job_details_screen.dart';

class JobOpportunitiesTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(JobDetailsScreen.routeName),
      child: Container(
        height: 275,
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                width: double.infinity,
                child: Image.asset(
                  'assets/images/poster.jpg',
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                height: 50,
                margin: EdgeInsets.symmetric(vertical: 7.5, horizontal: 5),
                child: Text(
                  'Kilifi County that have been for a long time affected by water shortages.The County Government has also been on the fore front in the installation and construction of over 500 storage tanks in all the 35 wards of Kilifi County.',
                  softWrap: true,
                  overflow: TextOverflow.fade,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
