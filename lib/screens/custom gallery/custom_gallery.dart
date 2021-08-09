import 'package:flutter/material.dart';
import 'package:kilifi_county/screens/custom%20gallery/collapsible_gallery.dart';
import 'package:kilifi_county/screens/custom%20gallery/fullscreen_gallery.dart';

class Gallery extends StatelessWidget {
  static const routeName = '/gallery';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FullscreenGallery()),
                );
              },
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.green,
              ),
              child: const Text('Full screen mode'),
            ),
            const SizedBox(height: 20.0),
            TextButton(
              onPressed: () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CollapsableGallery()),
                );
              },
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.green,
              ),
              child: const Text('Collapsable mode'),
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
