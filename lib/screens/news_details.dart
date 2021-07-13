import 'package:flutter/material.dart';
import 'package:kilifi_county/constants.dart';

class NewsDetailsScreen extends StatelessWidget {
  static const routeName = '/news-details';

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        children: [
          TopBar(),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
              child: kDetails),
        ],
      ),
    );
  }
}

class TopBar extends StatelessWidget {
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
            child: Image.asset(
              'assets/images/news.jpg',
              fit: BoxFit.cover,
            )),
      ),
      Container(
        width: size.width,
        margin: EdgeInsets.only(left: 20, right: 20),
        child: Center(
          child: Text(
            'Kilifi County has made strides in the battle against illiteracy',
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
              backgroundImage: AssetImage('assets/images/poster.jpg'),
            ),
            SizedBox(
              width: 7,
            ),
            Text(
              'Governor',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            Spacer(),
          ],
        ),
      )
    ]);
  }
}
