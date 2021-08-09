import 'package:flutter/material.dart';
import 'package:kilifi_county/models/post_models.dart';
import 'package:story/story.dart';

class StoriesPage extends StatelessWidget {
  static const routeName = '/stories-full';

  @override
  Widget build(BuildContext context) {
    var isDragging;
    void _closeStory() {
      Navigator.of(context).pop();
    }

    final story = ModalRoute.of(context).settings.arguments as StoryModel;
    return Scaffold(
      body: StoryPageView(
        itemBuilder: (context, pageIndex, storyIndex) {
          // final user = sampleUsers[pageIndex];
          // final story = user.stories[storyIndex];
          return GestureDetector(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(color: Colors.black),
                ),
                Positioned.fill(
                  child: Image.network(
                    story.postPics.first,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 44, left: 8),
                  child: Row(
                    children: [
                      Container(
                        height: 32,
                        width: 32,
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
        pageLength: story.postPics.length,
        storyLength: (int pageIndex) {
          return 2;
        },
        onPageLimitReached: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
