import 'package:flutter/material.dart';
import 'package:kilifi_county/constants.dart';
import 'package:kilifi_county/models/news_model.dart';

class NewsDetailsScreen extends StatelessWidget {
  static const routeName = '/news-details';

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    final news = ModalRoute.of(context).settings.arguments as NewsModel;
    return Scaffold(
      body: ListView(
        children: [
          TopBar(news: news),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
              child: Text(news.article)),
        ],
      ),
    );
  }
}

class TopBar extends StatelessWidget {
  final NewsModel news;
  TopBar({this.news});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(children: [
      Container(
        height: 230,
        width: size.width,
        child: ShaderMask(
            shaderCallback: (rect) {
              return LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black, Colors.black, Colors.transparent],
              ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
            },
            blendMode: BlendMode.dstIn,
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 200),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, i) => Container(
                  width: size.width,
                  child: Image.network(
                    news.images[i],
                    fit: BoxFit.cover,
                  ),
                ),
                itemCount: news.images.length,
              ),
            )),
      ),
      Container(
        width: size.width,
        margin: EdgeInsets.only(left: 20, right: 20),
        child: Center(
          child: Text(
            news.title,
            softWrap: true,
            overflow: TextOverflow.fade,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Row(
          children: [
            CircleAvatar(
              radius: 10,
              backgroundImage: NetworkImage(news.profilePic),
            ),
            SizedBox(
              width: 7,
            ),
            Text(
              news.fullName,
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            Spacer(),
          ],
        ),
      )
    ]);
  }
}
