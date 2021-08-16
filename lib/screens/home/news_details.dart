import 'package:flutter/material.dart';
import 'package:kilifi_county/constants.dart';
import 'package:kilifi_county/models/news_model.dart';
import 'package:kilifi_county/models/post_models.dart';

class NewsDetailsScreen extends StatelessWidget {
  static const routeName = '/news-details';

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    final news = ModalRoute.of(context).settings.arguments as NewsModel;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
                elevation: 0,
                expandedHeight: 250,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(news.title,
                      style: TextStyle(fontSize: 15.0, shadows: [
                        Shadow(
                            color: Theme.of(context).primaryColor,
                            blurRadius: 5)
                      ])),
                  background: AnimatedSwitcher(
                      duration: Duration(milliseconds: 200),
                      child: ListView.builder(
                        itemBuilder: (ctx, i) => Hero(
                          tag: news.postId,
                          transitionOnUserGestures: true,
                          child: Container(
                            height: 250,
                            child: cachedImage(
                              url: news.imageUrl,
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
                              margin: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 20),
                              child: Text(
                                news.article,
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
    );
  }
}
