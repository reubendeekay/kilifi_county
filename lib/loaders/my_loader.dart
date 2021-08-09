import 'package:flutter/material.dart';
import 'package:kilifi_county/constants.dart';
import 'package:kilifi_county/loaders/color_loader.dart';

class MyLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height,
      width: size.width,
      child: Center(
        child: ColorLoader5(
          dotIcon: Icon(Icons.adjust),
          dotOneColor: kPrimary,
          dotTwoColor: kSecondary,
          dotThreeColor: Colors.lightBlue,
          dotType: DotType.circle,
          duration: Duration(seconds: 2),
        ),
      ),
    );
  }
}
