import 'package:flutter/material.dart';
import 'package:kilifi_county/constants.dart';
import 'package:kilifi_county/models/job_model.dart';
import 'package:kilifi_county/models/post_models.dart';
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
                    expandedHeight: 300,
                    floating: false,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Text("Job Description",
                          style: TextStyle(fontSize: 15.0, shadows: [
                            Shadow(
                                color: Theme.of(context).primaryColor,
                                blurRadius: 5)
                          ])),
                      background: AnimatedSwitcher(
                          duration: Duration(milliseconds: 200),
                          child: ListView.builder(
                            itemBuilder: (ctx, i) => Hero(
                              tag: job.jobId,
                              transitionOnUserGestures: true,
                              child: Container(
                                height: 300,
                                child: cachedImage(
                                  url: job.jobPoster,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            itemCount: 1,
                          )),
                    )),
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (context, i) => Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.all(10),
                                  child: Text(
                                    job.description,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(fontSize: 15),
                                  ),
                                )
                              ],
                            ),
                        childCount: 1))
              ],
            ),
          ),
          SizedBox(
            width: size.width - 50,
            child: ElevatedButton(
              onPressed: () async {
                await canLaunch(job.link)
                    ? await launch(
                        job.link,
                      )
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
