import 'package:flutter/material.dart';

import '../Home/InformationOFCourses/CourseInformation.dart';

class AboutELearning extends StatelessWidget {
   AboutELearning({super.key ,required this.url});
  String url ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About E_Learning'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: VideoPlayerScreen(videoUrl: url,)
              ),
            )
          ],
        ),
      ),
    );
  }
}
