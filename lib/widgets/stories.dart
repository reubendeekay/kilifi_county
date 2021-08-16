import 'package:flutter/material.dart';
import 'package:kilifi_county/models/post_models.dart';
import 'package:story/story.dart';

class StoriesPage extends StatelessWidget {
  static const routeName = '/stories-full';

  @override
  Widget build(BuildContext context) {
    final story = ModalRoute.of(context).settings.arguments as StoryModel;
    return Scaffold(
      body: SafeArea(
        child: StoryPageView(
          itemBuilder: (context, pageIndex, storyIndex) {
            // final user = sampleUsers[pageIndex];
            // final story = user.stories[storyIndex];
            return GestureDetector(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(color: Colors.grey),
                  ),
                  Center(
                    child: Hero(
                      tag: story.postId,
                      transitionOnUserGestures: true,
                      child: cachedImage(
                        url: story.postPics.first,
                        // fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 44, left: 8),
                    child: Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(story.imageUrl),
                              fit: BoxFit.cover,
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          story.fullName,
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          gestureItemBuilder: (context, pageIndex, storyIndex) {
            return Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 32),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  color: Colors.white,
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            );
          },
          pageLength: 10,
          storyLength: (int pageIndex) {
            return story.postPics.length;
          },
          onPageLimitReached: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
