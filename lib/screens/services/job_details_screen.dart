import 'package:flutter/material.dart';
import 'package:kilifi_county/constants.dart';

class JobDetailsScreen extends StatelessWidget {
  static const routeName = '/job-details';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  elevation: 0,
                  expandedHeight: 250,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Text("Job Description",
                          style: TextStyle(
                            fontSize: 15.0,
                          )),
                      background: Container(
                        height: 250,
                        child: Image.asset(
                          'assets/images/poster.jpg',
                          fit: BoxFit.fill,
                        ),
                      )),
                ),
                SliverList(
                    delegate: SliverChildBuilderDelegate((context, i) => Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(10),
                              child: kDetails,
                            )
                          ],
                        )))
              ],
            ),
          ),
          SizedBox(
            width: size.width - 50,
            child: ElevatedButton(
              onPressed: () {},
              child: Text(
                'Apply',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
