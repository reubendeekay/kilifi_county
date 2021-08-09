import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ConnectScreen extends StatelessWidget {
  static const routeName = '/connect-with-us';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connect with Us'),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConnectWithUsTile(
              image: 'fb.png',
              title: 'Facebook',
              accountname: 'kilifi county',
              link:
                  'https://www.facebook.com/pages/Governor-Amason-Jeffah-Kingi/1597448460478247',
            ),
            ConnectWithUsTile(
              image: 'twitter.png',
              title: 'Twitter',
              accountname: '@governorkingi',
              link: 'https://twitter.com/governorkingi',
            ),
            ConnectWithUsTile(
              image: 'insta.png',
              title: 'Instagram',
              link:
                  'https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&cad=rja&uact=8&ved=2ahUKEwjY9eGY2fHxAhXEA2MBHSalDAMQFjAAegQIBRAD&url=https%3A%2F%2Fwww.instagram.com%2Fajkingi_003%2F%3Fhl%3Den&usg=AOvVaw3ObgIOvJoQCjX4daUXD5KW',
              accountname: '@ajkingi',
            ),
            ConnectWithUsTile(
              image: 'yt.png',
              title: 'Youtube',
              accountname: 'Amason J. Kingi',
              link: 'https://www.youtube.com/channel/UCROtNOvE2bbydhVHGcMwwdQ',
            ),
            ConnectWithUsTile(
              image: 'web.png',
              title: 'Website',
              link: 'https://www.kilifi.go.ke/',
              accountname: 'kilifi.go.ke',
            )
          ],
        ),
      ),
    );
  }
}

class ConnectWithUsTile extends StatelessWidget {
  final String image;
  final String title;
  final String accountname;
  final String link;

  const ConnectWithUsTile(
      {this.image, this.title, this.accountname, this.link});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
          height: 25,
          child: Image.asset(
            'assets/images/$image',
            fit: BoxFit.fill,
          )),
      title: Text(title),
      subtitle: Text(accountname),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        size: 14,
        color: Colors.grey,
      ),
      dense: true,
      onTap: () async {
        await canLaunch(link)
            ? await launch(link)
            : throw 'Could not launch $title ';
      },
    );
  }
}
