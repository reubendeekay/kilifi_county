import 'package:flutter/material.dart';
import 'package:kilifi_county/constants.dart';
import 'package:kilifi_county/models/job_model.dart';
import 'package:url_launcher/url_launcher.dart';

class JobDetailsScreen extends StatelessWidget {
  static const routeName = '/job-details';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final job = ModalRoute.of(context).settings.arguments as JobModel;
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
                      background: AnimatedSwitcher(
                          duration: Duration(milliseconds: 200),
                          child: ListView.builder(
                            itemBuilder: (ctx, i) => Container(
                              height: 250,
                              child: Image.network(
                                job.postPics[i],
                                fit: BoxFit.fill,
                              ),
                            ),
                            itemCount: job.postPics.length,
                          )),
                    )),
                SliverList(
                    delegate: SliverChildBuilderDelegate((context, i) => Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(10),
                              child: Text(job.description),
                            )
                          ],
                        )))
              ],
            ),
          ),
          SizedBox(
            width: size.width - 50,
            child: ElevatedButton(
              onPressed: () async {
                await canLaunch(job.link)
                    ? await launch(job.link)
                    : throw 'The link for application is invalid';
              },
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
