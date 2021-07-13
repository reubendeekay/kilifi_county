import 'package:flutter/material.dart';
import 'package:kilifi_county/screens/news_details.dart';

class NewsTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(NewsDetailsScreen.routeName),
      child: Container(
        margin: EdgeInsets.fromLTRB(15, 0, 15, 5),
        height: 82,
        width: double.infinity,
        child: Row(
          children: [
            Container(
              height: double.infinity,
              width: 100,
              child: ShaderMask(
                shaderCallback: (rect) {
                  return LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.black,
                      Colors.black,
                      Colors.black,
                      Colors.transparent
                    ],
                  ).createShader(
                      Rect.fromLTRB(0, rect.top, rect.width, rect.bottom));
                },
                blendMode: BlendMode.dstIn,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
                  child: Image.asset(
                    'assets/images/news.jpg',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: size.width - 150,
                  height: 57,
                  margin: EdgeInsets.only(top: 5, bottom: 5, right: 5),
                  child: Text(
                    'Kilifi County has made strides in the battle against illiteracy',
                    softWrap: true,
                    overflow: TextOverflow.fade,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ),
                Spacer(),
                Container(
                  margin: EdgeInsets.fromLTRB(2, 0, 2, 2),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 6,
                        backgroundImage: AssetImage('assets/images/poster.jpg'),
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Text(
                        'Governor',
                        style: TextStyle(color: Colors.grey, fontSize: 11),
                      ),
                      Container(
                        width: 130,
                        alignment: Alignment.bottomRight,
                        child: Text(
                          '08:19',
                          style: TextStyle(color: Colors.grey, fontSize: 11),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class News extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (ctx, i) => NewsTile(),
      itemCount: 10,
    );
  }
}
